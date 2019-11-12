Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC9FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7564F214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573540379;
	bh=cjNX+LG2ikMSXXwt1FQ3TrF7qIEv5ggJXgjZnZIVXD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m91KYmesFLG2D6zGyWApGUUAb6iZ5Y113yq/yLRHW/p4aTlJuuO4z2eb8TSkBlTGr
	 R2e0wUE1+fyfvN4HkRbZWkvo4Gc/9sjcncgiYg2tTj6iDbkigOE5jMpH4m5yWWPKD+
	 ulGIOhSfbcMWt/QCXkCUXdPmqRpuXtd/LW1t4xWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKLGc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 01:32:58 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53799 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfKLGc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 01:32:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id u18so1755952wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 22:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ks8g1RRafUnsXVngQDv+zMJC+iHCZd3MBlCsPeClAKY=;
        b=FPH5AmkxTHUMPO/GoizKLNwSyrk5Yj4GGHNIneMQWphvdL2/MayLADx8r/6AIfQI70
         zvq8NmWHXR2LslOvEITL6yuuiH15v3vFWv1wrBNGLp8LL8cQA45rRU/eNe+i4roy7Rbw
         DT7xWRb/RkPRU8r339p9WdoheKKtLxdtKe25Lknoqw3fFfQXEnO3MBUTzx1RND2ZHqrk
         f8QeAAEn1Fcp8YNFkOGtH/qpGO5TLEim18y5YAu2g+7A6DtnFbYZidPffFjoQnSMaINg
         HjUhU2Hiq0pQUkqRS5Le9HGT2ft8bUJPMcu/pQIX5HIovN4xMOLDWOrkwICppJUp8+Zq
         cz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ks8g1RRafUnsXVngQDv+zMJC+iHCZd3MBlCsPeClAKY=;
        b=SWNyR2qTfEHwxS6NUtyDFbsOlV+JTFDLJQiN1Rvnni+hAgkqlgt+1YoLf/52ktSDKT
         m0s/Q46t3vBUKu1MnI+Z9uinwPsExmZOVBR38kTgPOu3LuxsL4dpgC00OX0oMDkg2k0z
         yGf7WgK5CumzwbmCbxbF/nRez9a/XFzsqGKfRsX6n5Qr5J8DXF05kjNDKn4jpy2R2ct7
         o6p92wVxjIzU6XFZvCk7wzeber+4BFpL2j1h1DGX4M7NNwlKx+0z9U0C1Qp6NtbRQnoI
         Kx4yLdKpsFLLvODfrtZQuoF28SdvS11WF8ZVTVZXCOkcCyN4Y5t56FXceYcs+4HhozYV
         g8wQ==
X-Gm-Message-State: APjAAAUzS7DSTumIxd8icRyOGuuHRrHduQWZNLFlUGHgVoBp8muqQjO+
        9p/FQOd1x4/4JKjO/RbZzwE=
X-Google-Smtp-Source: APXvYqzhwmu5rFXdFFqo8WFw/OoLGZs+6lDR1DSBTDSdTGxrKnHMkgORYahu5YwpX19vYnZ0l4dqtg==
X-Received: by 2002:a1c:a90f:: with SMTP id s15mr2337560wme.100.1573540375494;
        Mon, 11 Nov 2019 22:32:55 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id j14sm19107399wrp.16.2019.11.11.22.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 22:32:54 -0800 (PST)
Date:   Tue, 12 Nov 2019 07:32:52 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V2 14/16] x86/iopl: Restrict iopl() permission scope
Message-ID: <20191112063252.GB100264@gmail.com>
References: <20191111220314.519933535@linutronix.de>
 <20191111223052.881699933@linutronix.de>
 <alpine.DEB.2.21.1911120000560.1833@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911120000560.1833@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> --- a/arch/x86/kernel/ioport.c
> +++ b/arch/x86/kernel/ioport.c
> @@ -18,12 +18,15 @@ static atomic64_t io_bitmap_sequence;
>  
>  void io_bitmap_share(struct task_struct *tsk)
>   {
> -	/*
> -	 * Take a refcount on current's bitmap. It can be used by
> -	 * both tasks as long as none of them changes the bitmap.
> -	 */
> -	refcount_inc(&current->thread.io_bitmap->refcnt);
> -	tsk->thread.io_bitmap = current->thread.io_bitmap;
> +	 /* Can be NULL when current->thread.iopl_emul == 3 */
> +	 if (current->thread.io_bitmap) {
> +		 /*
> +		  * Take a refcount on current's bitmap. It can be used by
> +		  * both tasks as long as none of them changes the bitmap.
> +		  */
> +		 refcount_inc(&current->thread.io_bitmap->refcnt);
> +		 tsk->thread.io_bitmap = current->thread.io_bitmap;
> +	 }

Minor side note: whitespace damage managed to slip in that code, see the 
fix below.

Thanks,

	Ingo

 arch/x86/kernel/ioport.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index f87844e22ec9..ee37a1c25ecc 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -17,16 +17,16 @@
 static atomic64_t io_bitmap_sequence;
 
 void io_bitmap_share(struct task_struct *tsk)
- {
-	 /* Can be NULL when current->thread.iopl_emul == 3 */
-	 if (current->thread.io_bitmap) {
-		 /*
-		  * Take a refcount on current's bitmap. It can be used by
-		  * both tasks as long as none of them changes the bitmap.
-		  */
-		 refcount_inc(&current->thread.io_bitmap->refcnt);
-		 tsk->thread.io_bitmap = current->thread.io_bitmap;
-	 }
+{
+	/* Can be NULL when current->thread.iopl_emul == 3 */
+	if (current->thread.io_bitmap) {
+		/*
+		 * Take a refcount on current's bitmap. It can be used by
+		 * both tasks as long as none of them changes the bitmap.
+		 */
+		refcount_inc(&current->thread.io_bitmap->refcnt);
+		tsk->thread.io_bitmap = current->thread.io_bitmap;
+	}
 	set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
 }
 
