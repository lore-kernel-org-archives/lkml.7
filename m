Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833EFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DB3218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n3rl18Ot";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V7EvBPIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfDXMKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:10:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58050 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfDXMKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:10:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9E2B660779; Wed, 24 Apr 2019 12:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556107848;
        bh=F7OeXqgr9Vwo8TOzmtJZrBds1fz82hjy6lKoYGAPhbQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=n3rl18Ot1zNmn6kYvNQG1o98TvA5py1b7PwhMm6JFugVEFGPcmTcp01QHF3Fn0sEz
         zLhpFABkOD7c/+vqJDWjl7m7d8fNMzOJAjK10zFHSNo+/wlJWQI26CfcErTFBJWZPX
         m0HCMh/47bLEg5wyDXRMPM/GHgOOdfYrIxJt/POI=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D80F3602F3;
        Wed, 24 Apr 2019 12:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556107847;
        bh=F7OeXqgr9Vwo8TOzmtJZrBds1fz82hjy6lKoYGAPhbQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=V7EvBPICdZRHJT98AO04VNfRwQSgQoFKwxHw0XBN/gGKOxE5bfPSnOrLZwPLM+h7d
         NALXMK/lmcoiVibqnXgqGYj5vjl1Ysi6INFCQnx8S228ZFn9u+B74hgXWIb8g63WMz
         hx0WwUwhj775v7JthQzjo6t13eK1jDapY0Bjbpg0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D80F3602F3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2] Input: uinput: Avoid Object-Already-Free with a global
 lock
To:     Al Viro <viro@zeniv.linux.org.uk>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gaurav Kohli <gkohli@codeaurora.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Martin Kepplinger <martink@posteo.de>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
References: <1554883176-24318-1-git-send-email-mojha@codeaurora.org>
 <7299a6db-38b7-75c7-633a-00d2257eba45@codeaurora.org>
 <20190418014321.dptin7tpxpldhsns@penguin>
 <bb92c3f2-faf1-04ec-4c67-3aba56c507a9@codeaurora.org>
 <a4d1a2f3-1db7-e300-9569-7b7a2fadd64e@codeaurora.org>
 <20190419071152.x5ghvbybjhv76uxt@penguin>
 <f3cd46fb-2bb1-0422-b2be-3f7625ec9c4e@codeaurora.org>
 <20190423032839.xvbldglrmjxkdntj@penguin>
 <17f4a0be-ab04-8537-9197-32fbca807f3f@codeaurora.org>
 <20190423084944.gj2boxfcg7lp4zad@penguin>
 <20190423110611.GL2217@ZenIV.linux.org.uk>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <5614f04f-827d-1668-9ed0-60d93e110b8e@codeaurora.org>
Date:   Wed, 24 Apr 2019 17:40:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423110611.GL2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/23/2019 4:36 PM, Al Viro wrote:
> On Tue, Apr 23, 2019 at 08:49:44AM +0000, dmitry.torokhov@gmail.com wrote:
>> On Tue, Apr 23, 2019 at 12:51:13PM +0530, Mukesh Ojha wrote:
>>> I have taken care this case from ioctl and release point of view.
>>>
>>> Even if the release gets called first it will make the
>>> file->private_data=NULL.
>>> and further call to ioctl will not be a problem as the check is already
>>> there.
>> Al, do we have any protections in VFS layer from userspace hanging onto
>> a file descriptor and calling ioctl() on it even as another thread
>> calls close() on the same fd?
>>
>> Should the issue be solved by individual drivers, or more careful
>> accounting for currently running operations is needed at VFS layer?
> Neither.  An overlap of ->release() and ->ioctl() is possible only
> if you've got memory corruption somewhere.
>
> close() overlapping ioctl() is certainly possible, and won't trigger
> that at all - sys_ioctl() holds onto reference to struct file, so
> its refcount won't reach zero until we are done with it.

Al,

i tried to put traceprintk inside ioctl after fdget and fdput on a 
simple call of open  => ioctl => close
on /dev/uinput.

           uinput-532   [002] ....    45.312044: SYSC_ioctl: 2     <= 
f_count >    <After fdget()
           uinput-532   [002] ....    45.312055: SYSC_ioctl: 
2            <After fdput()
           uinput-532   [004] ....    45.313766: uinput_open: uinput: 1
           uinput-532   [004] ....    45.313783: SYSC_ioctl: 1
           uinput-532   [004] ....    45.313788: uinput_ioctl_handler: 
uinput: uinput_ioctl_handler, 1
           uinput-532   [004] ....    45.313835: SYSC_ioctl: 1
           uinput-532   [004] ....    45.313843: uinput_release: uinput:  0


So while a ioctl is running the f_count is 1, so a fput could be run and 
do atomic_long_dec_and_test
this could call release right ?

-Mukesh

