Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DEDC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1F121655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfLLNxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:53:42 -0500
Received: from ns.iliad.fr ([212.27.33.1]:48600 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729429AbfLLNxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 08:53:42 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 4558D204CB;
        Thu, 12 Dec 2019 14:53:40 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 2CF8E200E6;
        Thu, 12 Dec 2019 14:53:40 +0100 (CET)
Subject: Re: [PATCH v1] clk: Convert managed get functions to devm_add_action
 API
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <3d8a58bf-0814-1ec1-038a-10a20b9646ad@free.fr>
 <20191128185630.GK82109@yoga> <20191202014237.GR248138@dtor-ws>
 <f177ef95-ef7e-cab0-1322-6de28f18ecdb@free.fr>
 <c0ccca86-b7b1-b587-60c1-4794376fa789@arm.com>
 <ba630966-5479-c831-d0e2-bc2eb12bc317@free.fr>
 <20191211222829.GV50317@dtor-ws>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <70528f77-ca10-01cd-153b-23486ce87d45@free.fr>
Date:   Thu, 12 Dec 2019 14:53:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211222829.GV50317@dtor-ws>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Dec 12 14:53:40 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2019 23:28, Dmitry Torokhov wrote:

> On Wed, Dec 11, 2019 at 05:17:28PM +0100, Marc Gonzalez wrote:
>
>> What is the rationale for the devm_add_action API?
> 
> For one-off and maybe complex unwind actions in drivers that wish to use
> devm API (as mixing devm and manual release is verboten). Also is often
> used when some core subsystem does not provide enough devm APIs.

Thanks for the insight, Dmitry. Thanks to Robin too.

This is what I understand so far:

devm_add_action() is nice because it hides/factorizes the complexity
of the devres API, but it incurs a small storage overhead of one
pointer per call, which makes it unfit for frequently used actions,
such as clk_get.

Is that correct?

My question is: why not design the API without the small overhead?

Proof of concept below:


diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 0bbb328bd17f..76392dd6273b 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -685,6 +685,20 @@ int devres_release_group(struct device *dev, void *id)
 }
 EXPORT_SYMBOL_GPL(devres_release_group);
 
+void *devm_add(struct device *dev, dr_release_t func, void *arg, size_t size)
+{
+	void *data = devres_alloc(func, size, GFP_KERNEL);
+
+	if (data) {
+		memcpy(data, arg, size);
+		devres_add(dev, data);
+	} else
+		func(dev, arg);
+
+	return data;
+}
+EXPORT_SYMBOL_GPL(devm_add);
+
 /*
  * Custom devres actions allow inserting a simple function call
  * into the teadown sequence.
diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index be160764911b..8db671823126 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -4,6 +4,11 @@
 #include <linux/export.h>
 #include <linux/gfp.h>
 
+static void __clk_put(struct device *dev, void *data)
+{
+	clk_put(*(struct clk **)data);
+}
+
 static void devm_clk_release(struct device *dev, void *res)
 {
 	clk_put(*(struct clk **)res);
@@ -11,19 +16,11 @@ static void devm_clk_release(struct device *dev, void *res)
 
 struct clk *devm_clk_get(struct device *dev, const char *id)
 {
-	struct clk **ptr, *clk;
-
-	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
+	struct clk *clk = clk_get(dev, id);
 
-	clk = clk_get(dev, id);
-	if (!IS_ERR(clk)) {
-		*ptr = clk;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
+	if (!IS_ERR(clk))
+		if (!devm_add(dev, __clk_put, &clk, sizeof(clk)))
+			clk = ERR_PTR(-ENOMEM);
 
 	return clk;
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index e226030c1df3..5acb61ec39ab 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -970,6 +970,7 @@ void __iomem *devm_of_iomap(struct device *dev,
 			    resource_size_t *size);
 
 /* allows to add/remove a custom action to devres stack */
+void *devm_add(struct device *dev, dr_release_t func, void *arg, size_t size);
 int devm_add_action(struct device *dev, void (*action)(void *), void *data);
 void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
 void devm_release_action(struct device *dev, void (*action)(void *), void *data);

