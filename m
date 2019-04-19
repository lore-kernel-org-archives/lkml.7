Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF8AC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387D420643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tN/neoFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfDSTAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:00:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35387 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfDSTAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:00:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id o12so4618713wrn.2;
        Fri, 19 Apr 2019 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hdkM2PeCiev4S3ru1KHFjlia2CRlV+k0hRdgNzdbShg=;
        b=tN/neoFGL4skwW+u09oN463qm9IBjVisDo/xSAZhHUMgGGye11EEcmQPGuovj4xybg
         spbcIqFYarHMI1U3VAx1ENNC7494mbwIOJbpVQVVOVEElRr/ZsNpaPgaCPdyHwe6OODs
         9iRoGIaoLNxTfHSBbtTEBUqppxXj4FXYa38UvwH2i1iGHp5QdW+OfO6RRvFgSRJfzTRu
         t286uLQI9L05IQyDqo7YRnUJvMnDZc4q578uZv6/HlJobNqfHEWbsNrXiEWL7RxjF2+U
         +NTeu3V+pLhkjp7v582mL1h9sjxMYG/27uqe7Y+1iWn7bnQzQDDl3fIzzsdJ7NIKtGJf
         zp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hdkM2PeCiev4S3ru1KHFjlia2CRlV+k0hRdgNzdbShg=;
        b=gHw9LWB9PWDIpDYzIQhbIPcjbIuYsbxm0ZGJwhqJYbvMqUjdTpfei6s69l5j1EMgi2
         eI/ApKtAifnnmovhcMpscEid+SLqychX1Ev11mY0pPfjDFOWV1WepYfY/66LVLW0vR7N
         GdabQdoa/0CyypsqjlvxsgGvx5ninH9EuLcvbvmHCyts8fGMzWkRDzryU9XqaUR4Fm6a
         Mzx2TjGs8d67lIWdvS0HRygXR2DN7ftJTTchNP00yYJfZyhj7p1ezHRP/coL/sXf8EUu
         1zONO83IrHiiekga56T/21XVDvvCK4gAbv/PvWNaFv/3Ee9nHIZj/CJxJPIFC4E6n/CM
         eLvg==
X-Gm-Message-State: APjAAAXDRAaCV4apCmSMg0CBujahPn/Mdjs+D+lTOZa7eB9TOjv8kxS6
        itsAcCvQHGNugR0zd1gEl6kO71dV2iQ=
X-Google-Smtp-Source: APXvYqy01l9XvWn+F15sy1PBImGX3j6d+eK+HRwX6rDlzGFgyR4xc3LNmbt/pzond21+dpp5xFVIGg==
X-Received: by 2002:a5d:670b:: with SMTP id o11mr2247692wru.125.1555668323277;
        Fri, 19 Apr 2019 03:05:23 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id v184sm6245151wma.6.2019.04.19.03.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 03:05:22 -0700 (PDT)
Subject: [PATCH v3 03/11] platform/x86: asus-wmi: Increase the input buffer
 size of WMI methods
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
Message-ID: <5e1a56c3-0448-a648-e331-a2e1d0421b56@gmail.com>
Date:   Fri, 19 Apr 2019 12:05:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The asus-nb-wmi driver is matched by WMI alias but fails to load on TUF
Gaming series laptops producing multiple ACPI errors in the kernel log.

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
are expected, as the input buffer size is not verified. The original
function is replaced by a wrapper for a new method passing value 0 for the
last parameter. The new function will be used to control RGB keyboard
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
index 731ffd382426..ba04737ece0d 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -95,6 +95,7 @@ static bool ashs_present(void)
 struct bios_args {
 	u32 arg0;
 	u32 arg1;
+	u32 arg2; /* At least TUF Gaming series uses 3 dword input buffer. */
 } __packed;
 
 /*
@@ -219,11 +220,13 @@ static void asus_wmi_input_exit(struct asus_wmi *asus)
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
@@ -255,6 +258,11 @@ int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
 
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

