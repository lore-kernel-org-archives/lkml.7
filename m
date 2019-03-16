Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6EEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 21:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF038218A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 21:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFZ7AQS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfCPVEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 17:04:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43877 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfCPVEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 17:04:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id d17so12993395wre.10
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 14:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RbHGWSD8Bq2NdjiQ6xLoDiKi4+6Zpqlate+RPCnxF3s=;
        b=LFZ7AQS6ERgaWG7nrByJTKLP1bspfAapBFKZg2IkyxEu80nRIzqvs01f5tp2YrjlUY
         Pu8GklNjDGMZhJ5Es3wGSztq2MQTroEA87t0MAs3GhpVEuE47taA193cbbAK8XYP5Oj4
         BCkwVoUVJJpT1T22ZLfXadgq4R3HBPwaL4tVPhyRJH9TqDy5nbe2l4TTzpcHvSLNKfoM
         W3X4ydXJMr+O2DPPZCGKXipb95bUXarqYH8fCD0XU6zrRfzQC05Jsh8wBH0VvGb4Sjet
         KRoA5C8Ueu2+kQomvesispPAR8FmOLlybsRTUlqytuDsZgkobIkyFVN22TXBYONazQtK
         Fy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RbHGWSD8Bq2NdjiQ6xLoDiKi4+6Zpqlate+RPCnxF3s=;
        b=cKcFDnbFxrZsA5n9/rP1Eyi2zlvlobhkA4VepNu9fHnPcmMepK7E8azTyFL4eNkobV
         2pdFn/ZTtbz+QBqR1wr5PP6Yr77xnmt60wVXekSnRlJ4tPuLkmYA5i0aFfmCU60BSW1Z
         wzhnjyRFiMksE4ktVKoAnJTN/vwAddWuWiIkYHKae8jzhPp59mBMFPz39WXYH7MPTwBS
         BvbzVO9S1Th+ToQ4AS7MjDYyNoGalSttjbTrVtX1lnTTQK1mgyPyAWXBQe9Hm6CP+L32
         czm7nbaa2kIwCZtMSoxTJZ4hv+mILY4x+HDcicXuAJLKTNIhgw3aZYOLFnAqvHuvoVqc
         m6ww==
X-Gm-Message-State: APjAAAUurjbf2L8NJPEdheHT2Hs43o8Gqnpf6jj4Gi+iPjGVBJmeuS7x
        7Aj/s74nQrOXwohdyyVM+A==
X-Google-Smtp-Source: APXvYqyniNlGjIZLXKYLDrirpyvOAMo2FN7ftkMFOSSpcUkYc+YpPJo8Qvcu/8NEAbTtuK2QhAULzw==
X-Received: by 2002:a5d:53c9:: with SMTP id a9mr707601wrw.59.1552770244330;
        Sat, 16 Mar 2019 14:04:04 -0700 (PDT)
Received: from avx2 ([46.53.243.195])
        by smtp.gmail.com with ESMTPSA id e193sm18450002wmg.18.2019.03.16.14.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 14:04:03 -0700 (PDT)
Date:   Sun, 17 Mar 2019 00:04:01 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] x86, putuser: cleanup 32-bit version a little
Message-ID: <20190316210401.GC21830@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete CONFIG_X86_32 references and _ASM_* macros.
Don't bother with anything else because i386 is dead.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/lib/putuser_32.S |   36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

--- a/arch/x86/lib/putuser_32.S
+++ b/arch/x86/lib/putuser_32.S
@@ -31,17 +31,17 @@
  * as they get called from within inline assembly.
  */
 
-#define ENTER	mov PER_CPU_VAR(current_task), %_ASM_BX
+#define ENTER	mov PER_CPU_VAR(current_task), %ebx
 #define EXIT	ASM_CLAC ;	\
 		ret
 
 .text
 ENTRY(__put_user_1)
 	ENTER
-	cmp TASK_addr_limit(%_ASM_BX),%_ASM_CX
+	cmp TASK_addr_limit(%ebx),%ecx
 	jae bad_put_user
 	ASM_STAC
-1:	movb %al,(%_ASM_CX)
+1:	movb %al,(%ecx)
 	xor %eax,%eax
 	EXIT
 ENDPROC(__put_user_1)
@@ -49,12 +49,12 @@ EXPORT_SYMBOL(__put_user_1)
 
 ENTRY(__put_user_2)
 	ENTER
-	mov TASK_addr_limit(%_ASM_BX),%_ASM_BX
-	sub $1,%_ASM_BX
-	cmp %_ASM_BX,%_ASM_CX
+	mov TASK_addr_limit(%ebx),%ebx
+	sub $1,%ebx
+	cmp %ebx,%ecx
 	jae bad_put_user
 	ASM_STAC
-2:	movw %ax,(%_ASM_CX)
+2:	movw %ax,(%ecx)
 	xor %eax,%eax
 	EXIT
 ENDPROC(__put_user_2)
@@ -62,12 +62,12 @@ EXPORT_SYMBOL(__put_user_2)
 
 ENTRY(__put_user_4)
 	ENTER
-	mov TASK_addr_limit(%_ASM_BX),%_ASM_BX
-	sub $3,%_ASM_BX
-	cmp %_ASM_BX,%_ASM_CX
+	mov TASK_addr_limit(%ebx),%ebx
+	sub $3,%ebx
+	cmp %ebx,%ecx
 	jae bad_put_user
 	ASM_STAC
-3:	movl %eax,(%_ASM_CX)
+3:	movl %eax,(%ecx)
 	xor %eax,%eax
 	EXIT
 ENDPROC(__put_user_4)
@@ -75,15 +75,13 @@ EXPORT_SYMBOL(__put_user_4)
 
 ENTRY(__put_user_8)
 	ENTER
-	mov TASK_addr_limit(%_ASM_BX),%_ASM_BX
-	sub $7,%_ASM_BX
-	cmp %_ASM_BX,%_ASM_CX
+	mov TASK_addr_limit(%ebx),%ebx
+	sub $7,%ebx
+	cmp %ebx,%ecx
 	jae bad_put_user
 	ASM_STAC
-4:	mov %_ASM_AX,(%_ASM_CX)
-#ifdef CONFIG_X86_32
-5:	movl %edx,4(%_ASM_CX)
-#endif
+4:	mov %eax,(%ecx)
+5:	movl %edx,4(%ecx)
 	xor %eax,%eax
 	EXIT
 ENDPROC(__put_user_8)
@@ -98,6 +96,4 @@ END(bad_put_user)
 	_ASM_EXTABLE_UA(2b, bad_put_user)
 	_ASM_EXTABLE_UA(3b, bad_put_user)
 	_ASM_EXTABLE_UA(4b, bad_put_user)
-#ifdef CONFIG_X86_32
 	_ASM_EXTABLE_UA(5b, bad_put_user)
-#endif
