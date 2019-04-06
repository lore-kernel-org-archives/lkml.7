Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4F0C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 19:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1E321019
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 19:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o6XxdVfX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Oav5Gxr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfDFTRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 15:17:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40210 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfDFTRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 15:17:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0C70F60D0C; Sat,  6 Apr 2019 19:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554578273;
        bh=5Qaauq7e6FfGQThLRgxCkta8VwuSwihOl+Fq9VzXhU0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=o6XxdVfXMX0njy88beJSNW1E1wvAWVrv9v+sK3PB+oCHdCFAtAZ/+LrtmqWN9dWAk
         eQk5DomEz3MHnSIKAgXbLHttwWTNnCiJQ5A4nfWnWlv+LXg6eSaUD53C2Mh6XmzuZ0
         2eXJq2RWjpuG67zjXxVnNZU3D97aTuFgRNzYsjP4=
Received: from [10.79.171.6] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A05D60115;
        Sat,  6 Apr 2019 19:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554578272;
        bh=5Qaauq7e6FfGQThLRgxCkta8VwuSwihOl+Fq9VzXhU0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Oav5Gxr/Fp8YAeMaowXLuwBmQ252wKpn9ttl8CJrMXSLqObtj1w7KmupmbxNrvJE1
         KnwQ3TAuXUnspfuJ32UBQB/Gu7RGjLFCduxucAlquosuINNPyptrEjUqZzLa+WzWKe
         dVyrqzVUl5IZcIy0L+ttSBjh1gD1YlPQAjrxMVms=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A05D60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] KVM: x86: fix warning Using plain integer as NULL pointer
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190406093658.GA7438@hari-Inspiron-1545>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <ea8cda8a-bda1-c227-6bd2-d8c3bb2f5681@codeaurora.org>
Date:   Sun, 7 Apr 2019 00:47:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190406093658.GA7438@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/2019 3:06 PM, Hariprasad Kelam wrote:
> Changed passing argument as "0 to NULL" which resolves below sparse warning
>
> arch/x86/kvm/x86.c:3096:61: warning: Using plain integer as NULL pointer
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   arch/x86/kvm/x86.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 099b851..39034ec 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3093,7 +3093,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   		break;
>   	case KVM_CAP_NESTED_STATE:
>   		r = kvm_x86_ops->get_nested_state ?
> -			kvm_x86_ops->get_nested_state(NULL, 0, 0) : 0;
> +			kvm_x86_ops->get_nested_state(NULL, NULL, 0) : 0;
>   		break;
>   	default:
>   		break;
