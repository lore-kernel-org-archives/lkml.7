Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47848C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 00:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B97A24396
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 00:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Wm4oED+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfE3AXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 20:23:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45386 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfE3AXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 20:23:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id w34so853031pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 17:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=dpN4wiii1TvSZMayJZekGyxBaLr+eeeO3Ruou2wN6wk=;
        b=Wm4oED+RlotHfcviCowYRWH7jw0M8K4gnkX4OOx30A/3cC7nN95j3QJ7f+r9ZfTpXw
         kAMMNMiHvTNlnDkGgIzqV2xzK2+MU8cGoVB+wibhXtWmVAFOG32U2AsRjEZZ+ao5hTSS
         Dfnb5mlnq1dVaAm037orKao9kDirTMAYVztlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dpN4wiii1TvSZMayJZekGyxBaLr+eeeO3Ruou2wN6wk=;
        b=fdz0X8BqVgi5PvWPiU5AVJX5yozbW5LH+n88CUSCc7Z29/SFB11EG0QUH5PPLnb24w
         t/oJwDWUvZ+H3OtqKUg7WN7RYPUn7qJpVOFsNk3CBFxbVw/ftTy+T7Cs6ILBNLdfs6AS
         wGjx52cABncxUF5wUYu4GOYXXtdQ3IrmkRWLW6JFI7eL3OKsq3v4BnzTDxi//QHENvXd
         7BQU66J/RuNW8UpClmuuLX2sHLFM8Nj57gSxgkR1L9R1LPHe/xs4EmaPeaJDbfKSVyIy
         2ND4nOYHEzGOP2GKkJp/4dUlXUeYgvsA7+DQ1g+Xw/F3AXtvK+I9lKfAjubvnyQuSg70
         r62Q==
X-Gm-Message-State: APjAAAVzGY3W78IH0Z16yYFA4UwCpAHLkiHzq8AQ7dmwZzpO6gC4oFor
        AgaEjn92IKeF6AZ/ea0N74GKT7Y19+gRR8rj/P92ukDP3l6VzHTl/P8qnQKdlMpVMv0Ns+i/BCX
        5IrogHdJlYpe2TdaRL7Y/FcXRJmjcec5ELyt0vA4ipj5SwlLCSO8vyj8cXuDdzeqCkyjGrqGSRM
        RwSXw=
X-Google-Smtp-Source: APXvYqxb78UBEIoNeOotRBjD6CKuJJD04hvvXvpNzIsDfEycRQp9UICYuvcNF1lZu+YtPu0dCCG3uw==
X-Received: by 2002:a17:90a:be0b:: with SMTP id a11mr762957pjs.88.1559175822636;
        Wed, 29 May 2019 17:23:42 -0700 (PDT)
Received: from [10.69.37.149] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s28sm446391pgl.88.2019.05.29.17.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 17:23:42 -0700 (PDT)
Subject: Re: [PATCH] scsi: lpfc: Use *_pool_zalloc rather than *_pool_alloc
To:     Thomas Meyer <thomas@m3y3r.de>, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1559161113889-196429735-0-diffsplit-thomas@m3y3r.de>
 <1559161113901-1017843021-1-diffsplit-thomas@m3y3r.de>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <8e9198f2-1247-f7bc-7856-721664b64316@broadcom.com>
Date:   Wed, 29 May 2019 17:23:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559161113901-1017843021-1-diffsplit-thomas@m3y3r.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/29/2019 1:21 PM, Thomas Meyer wrote:
> Use *_pool_zalloc rather than *_pool_alloc followed by memset with 0.
>
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
>
>

looks good

Reviewed-by: James Smart <james.smart@broadcom.com>

-- james

