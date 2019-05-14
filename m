Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0CCC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08092084F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZB9BiPN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfENSy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:54:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41474 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfENSy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:54:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id d12so20348764wrm.8;
        Tue, 14 May 2019 11:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1Vtv8vjo+k0fYAQaZ6ozljyJomIPXdJKSl6iEIq/F3I=;
        b=ZB9BiPN3mcV8aYqzXsJCUdohCAJcs08wznHfJLne6ytAI+7YW66CB4j1QAr2ejeI24
         ExZL6IRV+C9NnawmAZlpIK/w+So5zGRd6VfHyDgkMG1gDIi1O/9Wil+w9MaUBQUwaMDm
         YxZDEcBtjD/rBBahOKUssDBN8r6QwXdvtgal8m0fK+Oda3fQb/DX6d33LuxI/f84JUbR
         NpsTXTXY1+v2ehlxiFq3SCLUQdeHumdqOYZ9IkCKWB7lVKFOvRLh9oHOCL8q2JhRjdIy
         7cjVS//GqEo3uZBcPcdZPtPh4rbydR3cGLI9okWOED7gY+DK/TBV4jbEdpZI/qx2/Aak
         8XKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1Vtv8vjo+k0fYAQaZ6ozljyJomIPXdJKSl6iEIq/F3I=;
        b=YraSFOM3ruQDYKtXncObjgYGc3nI35eHPCuJNDNRy50ucI65UkNaOUQ8sZ6R9duza7
         hTTHMTia9g4eWXfFOdxqIH5wTSkDn0iaSr9sKkLrLu6Vuepkumb22A/xjHguVzCDrqr3
         v4GOsM9ROpZHP1C9kzFZlaxQ8QWhZzFKTCvaABlZv/ngwMlq9yn1BWruYrAXmzq2vdvf
         L7bQyZltuwtoR9SYrsmxgGDkpM9iuGyIwYjBplqNrfDCNI+XwEyp8okmmxRK5dqI209F
         eaobenUkQ0jxB/LuOm1IxUTARuIH//AqUH3w/aUvNLEUTFxkvRKpH457UNfLT2vKCveF
         QJcg==
X-Gm-Message-State: APjAAAVXTP99DOJ0EkUgqd1NRP5j+B+o2Dmqbxb1tNGuXwURSykmsKHA
        op33O1R2JfSl4mc+uVSkEQa+yeBW
X-Google-Smtp-Source: APXvYqwmzaWet/cwInE/bAm/HtJVcfbTml8/21zp+y0sovf2T8Cf+yRxZPqzQ9qNOVGsGvEv61ZE3g==
X-Received: by 2002:a5d:6145:: with SMTP id y5mr12600574wrt.96.1557860095100;
        Tue, 14 May 2019 11:54:55 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id a6sm14168275wrp.49.2019.05.14.11.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:54:54 -0700 (PDT)
Subject: [PATCH v4 03/13] platform/x86: asus-wmi: Increase input buffer size
 of WMI methods
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com>
Message-ID: <4613f54b-b6ba-c9ad-15ca-e43d440b9f63@gmail.com>
Date:   Tue, 14 May 2019 20:54:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com>
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
index 84d7fc6f941c..6b35c1f00a3e 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -98,6 +98,7 @@ static bool ashs_present(void)
 struct bios_args {
 	u32 arg0;
 	u32 arg1;
+	u32 arg2; /* At least TUF Gaming series uses 3 dword input buffer. */
 } __packed;
 
 /*
@@ -224,11 +225,13 @@ static void asus_wmi_input_exit(struct asus_wmi *asus)
 	asus->inputdev = NULL;
 }
 
-int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
+static int asus_wmi_evaluate_method3(u32 method_id,
+		u32 arg0, u32 arg1, u32 arg2, u32 *retval)
 {
 	struct bios_args args = {
 		.arg0 = arg0,
 		.arg1 = arg1,
+		.arg2 = arg2,
 	};
 	struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -260,6 +263,11 @@ int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
 
 	return 0;
 }
+
+int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
+{
+	return asus_wmi_evaluate_method3(method_id, arg0, arg1, 0, retval);
+}
 EXPORT_SYMBOL_GPL(asus_wmi_evaluate_method);
 
 static int asus_wmi_evaluate_method_agfn(const struct acpi_buffer args)
-- 
2.17.1

