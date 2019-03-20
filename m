Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E821AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC3420857
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZIiOfXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfCTTzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:55:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32974 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfCTTzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:55:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id i19so2694019pfd.0;
        Wed, 20 Mar 2019 12:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gd3n5In9i1Pe2yM741rdYswLRr8CqesH/BBfWc5owQs=;
        b=UZIiOfXRl5hAp9j2ZmNVRgbTYUhZLSxqlniUnojxVuYLmAc8B7wpAd4ts0eljC1puf
         32d71598Oj3WiZO3k4rzbc0v9KqIzyBbGvn6BY4uEz9Wistf8LKSwshMAaElSoOxhfjR
         6GMaxmfgvBBvoYNEW7bLoE+KNjIRUwZhHhGT1FPfmV/h5yL69ak/oRQYXch+qWqIQk9u
         pW6hIVTe93L4+WTXvuyZz2FQdC8Qgpk2EEuBDhIUZMJBHkUlEcI3uEojLb/UFYyaS2uC
         UaqrnulQO06imYaHFgGK5KGMDvpAhpa22BMaxb3QyjrVPh7csapVKvOiyab+qlHgL5Bw
         xPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gd3n5In9i1Pe2yM741rdYswLRr8CqesH/BBfWc5owQs=;
        b=OT7vna/ME0Cd4dRveBir+n9sFPffi4SAe2DmOaySjTNIjmT/zUMgvnasuNteXafpES
         aFiN7M3ROoZKyKe2oaqm7OpzPCLDOQu/0Yar0lfwLVKPN2tp7Kiaaxyhd4c5G5XAvecO
         cH3NayQsOeSNeuXBMLhEmIFw5IdxFbaUUs6q/OGuw3dKE8u6sezCDrY7dpkdP9DUZW7t
         JMmzztRy+t2D7nOxM0qDkWJYN4R9/UJFw+HjrUkWdAmbS9WFiTC1IOQe9ikMPxu4S50s
         wX+QqFu/7CQn/Li/3y6JnLDhsG8gwANfqeWSF82i1qxOs0IYwqpKEA2VCQ4rb2hIyxwB
         KqyA==
X-Gm-Message-State: APjAAAWMIOKofvd5kTJHM0+d24Ng004hN6X3wdyBQwEyp9U1r0/h+My7
        iQqXDZdg6ESkaPDe8T8DrQQ=
X-Google-Smtp-Source: APXvYqxM74zDqFLPwxoYNsanF8b6zT8bT/TqN18KElYiDXWphZGguN5QH05zW0aPQgQM1oD6ehxABA==
X-Received: by 2002:a63:bd51:: with SMTP id d17mr9046273pgp.117.1553111743973;
        Wed, 20 Mar 2019 12:55:43 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id p34sm3768687pgb.18.2019.03.20.12.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 12:55:43 -0700 (PDT)
Subject: Re: [PATCH] of: Drop redundant check in linker section OF match table
To:     Mukesh Ojha <mojha@codeaurora.org>, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org
References: <1553078940-9907-1-git-send-email-mojha@codeaurora.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <67db2d00-26d0-f9e3-f4dd-0f48633142a9@gmail.com>
Date:   Wed, 20 Mar 2019 12:55:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553078940-9907-1-git-send-email-mojha@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/19 3:49 AM, Mukesh Ojha wrote:
> Existing check of `fn` against NULL inside OF match table
> is redundant. Remove the check.
> 
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> Cc: devicetree@vger.kernel.org
> ---
>  include/linux/of.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index e240992..b86c00a 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -1283,13 +1283,13 @@ static inline int of_get_available_child_count(const struct device_node *np)
>  	static const struct of_device_id __of_table_##name		\
>  		__used __section(__##table##_of_table)			\
>  		 = { .compatible = compat,				\
> -		     .data = (fn == (fn_type)NULL) ? fn : fn  }
> +		     .data = fn }
>  #else
>  #define _OF_DECLARE(table, name, compat, fn, fn_type)			\
>  	static const struct of_device_id __of_table_##name		\
>  		__attribute__((unused))					\
>  		 = { .compatible = compat,				\
> -		     .data = (fn == (fn_type)NULL) ? fn : fn }
> +		     .data = fn }
>  #endif
>  
>  typedef int (*of_init_fn_2)(struct device_node *, struct device_node *);
> 

The check is not redundant and does serve a purpose.

The purpose is not very obvious on the surface, but it is checking that
the function fn() is of the proper type.

An example of a compiler warning with a bad function type is created
by applying the following patch:

   drivers/of/unittest.c:62:1: warning: comparison of distinct pointer types lacks a cast [enabled by default]

Note that you need to have CONFIG_UNITTEST enabled to compile unittest.c.

Line 62 is
   OF_DECLARE_1(__unittest_of_table, unittest_setup_2_bad, "unittest_compat",

---
 drivers/of/unittest.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

Index: b/drivers/of/unittest.c
===================================================================
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -45,6 +45,23 @@ static struct unittest_results {
 	failed; \
 })
 
+struct of_device_id __unittest_of_table;
+
+static void __init unittest_setup_1_good(struct device_node *np)
+{
+}
+
+static void __init unittest_setup_2_bad(struct device_node *np_1,
+	struct device_node *np_2)
+{
+}
+
+OF_DECLARE_1(__unittest_of_table, unittest_setup_1_good, "unittest_compat",
+	unittest_setup_1_good);
+
+OF_DECLARE_1(__unittest_of_table, unittest_setup_2_bad, "unittest_compat",
+	unittest_setup_2_bad);
+
 static void __init of_unittest_find_node_by_name(void)
 {
 	struct device_node *np;
