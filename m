Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4903C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D322173C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KRDx8SkP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Hobcm8bl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbfC3QRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:17:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34482 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbfC3QRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:17:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4D43C60790; Sat, 30 Mar 2019 16:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553962621;
        bh=IYH95s5Yr5FuY1fNL4ZN8mwKASSE6Monn3hW1rzsmPg=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=KRDx8SkPQZDAQaBSkyTyLhYIWiW7YcC2s23uREKSSiul5WJaMe7LyYayMqDdKp69C
         tedwn8Sb85SJaPWDgGgbKMpvftVugw0ixGeRfzKQGx+TPKlPwX8ZOw7y80y0U7uPy0
         s9xR71t6S/fAF2knORPHYY3QpYGVNgyH1jhNEwRE=
Received: from [10.79.166.167] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 379956072E;
        Sat, 30 Mar 2019 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553962620;
        bh=IYH95s5Yr5FuY1fNL4ZN8mwKASSE6Monn3hW1rzsmPg=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Hobcm8blHmMkV8p23wIRcvFHx1YF/rnRCGQS/aA08+eKuOjomOQsAuED21DRmVdai
         wJ8W3xfFqg1kcsY+wORTBa6Gqa2W/nyR+ev2tZV57LFu/U6NAM7F8NdhB10nR7+UYm
         Vo4s33QSx6aOKcZbkkKSFid+ECbFdJsyijvf/ht8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 379956072E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] fs/binfmt_elf.c: fix GPF when dereferencing invalid
 interpreter
To:     Nikitas Angelinas <nikitas.angelinas@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        syzbot+0d1fcd7268b21baced4a@syzkaller.appspotmail.com
References: <20190330140032.GA1527@vostro>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <47235084-9333-1096-e411-8d25ec120f30@codeaurora.org>
Date:   Sat, 30 Mar 2019 21:46:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190330140032.GA1527@vostro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/30/2019 7:30 PM, Nikitas Angelinas wrote:
> Syzkaller found an issue where an invalid interpreter pointer is
> dereferenced in load_elf_binary()->allow_write_access()


please mention here on failure path inside  allow_write_access

as there are two path it gets called.


> . Fix this by
> jumping to a different label in the cleanup path.
>
> This patch applies against the latest linux-next tree. I have not tested
> that the patch addresses the issue, but it should, imho.


This should not be written in commit text body.
please fix.

>
> Signed-off-by: Nikitas Angelinas <nikitas.angelinas@gmail.com>
> Reported-by: syzbot+0d1fcd7268b21baced4a@syzkaller.appspotmail.com
> Fixes: 44e63c4a0263 ("fs/binfmt_elf.c: free PT_INTERP filename ASAP")
> ---



Patch looks valid to me as interpreter may be NULL and it later get 
tried to dereferencing inside allow_write_access

under label out_free_dentry.


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>


Cheers,
-Mukesh

>   fs/binfmt_elf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 51bc894..09e76b2 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -777,7 +777,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>   			kfree(elf_interpreter);
>   			retval = PTR_ERR(interpreter);
>   			if (IS_ERR(interpreter))
> -				goto out_free_dentry;
> +				goto out_free_ph;
>   
>   			/*
>   			 * If the binary is not readable then enforce
