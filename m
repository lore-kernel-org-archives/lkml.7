Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB49DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814E120830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWqPVkji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfDJU1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:27:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46564 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDJU1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:27:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so4415800wrw.13;
        Wed, 10 Apr 2019 13:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sKemZIGXOLnXPFb232HtWCAbGcZYU1oZG05+t8UDDMk=;
        b=RWqPVkji8y28EF5i03pUDGTDGa4Jk440s0R8PIH8kgKUgt1OQHKc+pPV/1yxdsT7yG
         /gJRKmugrXQR6lsUZom/JBYLG8fOD1Xj8/v4LDD+fgl8VWONjck5EImZ/tgyPf0xugKS
         LMUPAHt5rdYGt9+86n82hJkVTdoDmH1nMG1k/6ULmhkI3TACoVgznwAMFzlf3BxQ7XB6
         wd2atpTm1iBWEsRvhD1uxXs8YYeuanO/jY9dbxLBw/Grw4DJ2Fw2rE+y8zJ8ewi31qOR
         whTgr7lBFyajZFMGVooAZdHrH25rLjkJGP8aVm8Mvo8W9LoOd7mQ25OasQVCev8ECPHY
         xqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sKemZIGXOLnXPFb232HtWCAbGcZYU1oZG05+t8UDDMk=;
        b=JLWc6wvxFno8/WdQXu+xhTpZczy8oRTFYztAZgUKdadrn7voKM/gNqvOTR6mnWEPU/
         xHaLbS4y++RTf2hW6ep1/JrchKUmEOOKX5kRYQaGtTGMMudCD2Hjl9XKM6/zOZQAjwQn
         lq25X8oSe5gcljEZy3d7XRe/pM/QYgeEjYdz7V2MEbdSt2CRI4DLQBf8BI2Pxemjtr/u
         H5IOVN/1Td5QIj4HdC/Ett8RwARs/E/YlmFDJxRp2uu6WuPFEFA65UXO3CaYuv2DJnlX
         HiChkZ3880NTfxbwSaCIHY5qokSVP8VKjWZn2zYSJHpCsPnyy1Hhc5B5U0dXbYGAW5ok
         5Z+Q==
X-Gm-Message-State: APjAAAULOAS9cuMm44DIzGGDFKmVxq4oDF77IdMcoBF1fRxO0hEPjPaP
        PhbFURi7p0BVVSCx/GYBlNFO40Fja7k=
X-Google-Smtp-Source: APXvYqzgx1xwMm/AnrvLzoY9lPLWc50SriYZ99zEd5f7mTaFGX5y2HUeq3abpciLHnx1sY28U2N2nA==
X-Received: by 2002:adf:e692:: with SMTP id r18mr24884899wrm.231.1554928061031;
        Wed, 10 Apr 2019 13:27:41 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id f128sm4193746wme.28.2019.04.10.13.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 13:27:40 -0700 (PDT)
Subject: [PATCH 03/11] platform/x86: asus-wmi: Increase input buffer size of
 WMI methods
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
Message-ID: <e2d32e44-5025-a39c-cc42-ec23eeffe6c8@gmail.com>
Date:   Wed, 10 Apr 2019 22:27:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The asus-nb-wmi driver is matched by WMI alias but fails to load on TUF
Gaming series laptops producing multiple ACPI errors in kernel log. Patch
was tested on TUF Gaming FX505GM and older K54C model.

The input buffer for WMI method invocation size is 2 dwords, whereas
3 are expected by this model.

FX505GM:
..
Method (WMNB, 3, Serialized)
{
    P8XH (Zero, 0x11)
    CreateDWordField (Arg2, Zero, IIA0)
    CreateDWordField (Arg2, 0x04, IIA1)
    CreateDWordField (Arg2, 0x08, IIA2)
    Local0 = (Arg1 & 0xFFFFFFFF)
    ...

Compare with older K54C:
...
Method (WMNB, 3, NotSerialized)
{
    CreateDWordField (Arg2, 0x00, IIA0)
    CreateDWordField (Arg2, 0x04, IIA1)
    Local0 = (Arg1 & 0xFFFFFFFF)
    ...

Increase buffer size to 3 dwords. No negative consequences of this change
are expected, as input buffer size is not verified. The original function
is replaced by a wrapper for a new method passing value 0 for the last
parameter. The new function will be used to control RGB keyboard
backlight.

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
---
One of current kernel errors:
ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT, Field [IIA2] at bit offset/
	length 64/32 exceeds size of target Buffer (64 bits)
	(20190215/dsopcode-203)
[ 4528.573948] No Local Variables are initialized for Method [WMNB]
[ 4528.573949] Initialized Arguments for Method [WMNB]:  (3 arguments
	defined for method invocation)
[ 4528.573950]   Arg0:   00000000bd1bea5a <Obj>
	Integer 0000000000000000
[ 4528.573952]   Arg1:   00000000d414dc53 <Obj>
	Integer 000000004E464741
[ 4528.573954]   Arg2:   00000000fcefea4b <Obj>
	Buffer(8) F0 95 08 00 00 00 00 00
[ 4528.573959] ACPI Error: Aborting method \_SB.ATKD.WMNB due to previous
	error (AE_AML_BUFFER_LIMIT) (20190215/psparse-531)
[ 4528.686425] asus-nb-wmi: probe of asus-nb-wmi failed with error -5
---
 drivers/platform/x86/asus-wmi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 0fbb947b07c4..cfccfc0b8c2f 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -95,6 +95,7 @@ static bool ashs_present(void)
 struct bios_args {
 	u32 arg0;
 	u32 arg1;
+	u32 arg2; /* At least TUF Gaming series uses 3 dword input buffer. */
 } __packed;
 
 /*
@@ -220,11 +221,13 @@ static void asus_wmi_input_exit(struct asus_wmi *asus)
 	asus->inputdev = NULL;
 }
 
-int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
+static int asus_wmi_evaluate_method_3dw(u32 method_id, u32 arg0, u32 arg1,
+		u32 arg2, u32 *retval)
 {
 	struct bios_args args = {
 		.arg0 = arg0,
 		.arg1 = arg1,
+		.arg2 = arg2
 	};
 	struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -256,6 +259,11 @@ int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
 
 	return 0;
 }
+
+int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
+{
+	return asus_wmi_evaluate_method_3dw(method_id, arg0, arg1, 0, retval);
+}
 EXPORT_SYMBOL_GPL(asus_wmi_evaluate_method);
 
 static int asus_wmi_evaluate_method_agfn(const struct acpi_buffer args)
-- 
2.17.1

