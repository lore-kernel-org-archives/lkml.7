Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A0AC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18ADE204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698699;
	bh=9EZTsllLlsdE9lck2TdP/bKYiYbB7SkWLK4Z7FhPoBo=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=f0z1pYaxRNu3Cps0lQCiehEisJ9FW13MBicdBWMlCoUfwflsTAdXHl9X0RoDaphZy
	 zRPw7n7KWo+hJooy/vth1LjMpj8Yx71F96NvGYHKFsrxisbFgR83VHKnnfseBUsjIz
	 Jucv7a+V7cI15iWZNGzUGNfpT3K5XGPVN/RUC1cw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfDSSbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:31:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbfDSS3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:17 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88DCE222A1;
        Fri, 19 Apr 2019 13:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555680007;
        bh=9EZTsllLlsdE9lck2TdP/bKYiYbB7SkWLK4Z7FhPoBo=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=SJyG3cobriifyKmFuvcR4EXqxD1/LSrmsa7MbmsDxfSUjc90y7fhkALBIvuORw+/Q
         k+RabzCUyzQZ8RLKOiX8xaWI751AC2ur2jS3IfMnKRv1xi4v+fv2YAuDK4xHLLvVvs
         n87Fy2CsNr7Vudl8aW3hgENTY48By/ffOdAsK7iU=
Subject: Re: [PATCHv2] selftests/efivarfs: clean up test files from
 test_create*()
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190419131221.28297-1-po-hsu.lin@canonical.com>
From:   shuah <shuah@kernel.org>
Message-ID: <03bdc88d-07cd-08ca-7d2f-ba93069eb41b@kernel.org>
Date:   Fri, 19 Apr 2019 07:19:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419131221.28297-1-po-hsu.lin@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/19 7:12 AM, Po-Hsu Lin wrote:
> Test files created by test_create*() tests will stay in the
> $efivarfs_mount directory unless the system was rebooted.
> 
> When the tester tries to run this efivarfs test again on the same
> system, the immutable characteristics in that directory will cause some
> "Operation not permitted" noises and a false-positve test result to the
> test_create_read() test.
> 
>      --------------------
>      running test_create
>      --------------------
>      ./efivarfs.sh: line 59: /sys/firmware/efi/efivars/test_create-210be57c-9849-4fc7-a635-e6382d1aec27: Operation not permitted
>        [PASS]
>      --------------------
>      running test_create_empty
>      --------------------
>      ./efivarfs.sh: line 78: /sys/firmware/efi/efivars/test_create_empty-210be57c-9849-4fc7-a635-e6382d1aec27: Operation not permitted
>       [PASS]
>      --------------------
>      running test_create_read
>      --------------------
>      open(O_WRONLY): Operation not permitted
>       [FAIL]
>      --------------------
> 
> Create a file_cleanup() to remove those test files in the end of each
> test to solve this issue.
> 
> Also, use this function to replace the existing file removal code.
> 
> Link: https://bugs.launchpad.net/bugs/1809704
> 
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---

Thanks for the patch. There is another patch that does the same in
linux-kselftest next branch.

Please check to see if that fixes the problem you are seeing.

thanks,
-- Shuah

