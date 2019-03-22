Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29802C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAE5218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="A9ZOfP2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfCVBFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:05:06 -0400
Received: from forward101j.mail.yandex.net ([5.45.198.241]:54254 "EHLO
        forward101j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726460AbfCVBFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:05:06 -0400
Received: from mxback7o.mail.yandex.net (mxback7o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::21])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id 503711BE1C77;
        Fri, 22 Mar 2019 04:05:02 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback7o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id dLlc1bbWIJ-52YShlQp;
        Fri, 22 Mar 2019 04:05:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1553216702;
        bh=L1J2bnwZwMzQDfRi/vRljhyIBNoCo35098icCbyTZRs=;
        h=In-Reply-To:From:To:Subject:Cc:Date:References:Message-ID;
        b=A9ZOfP2lDw+nT8zCp1y3g2JRMH5aKZaZ4u6e+h/MTGJjpd8dcEwUfK40BLrXzjYsx
         XkYO13HHBqrmTsT6tlAdIZ57qcNsFntWwkc5dngNWEM6Lj986UG86DYcg99jbFETy2
         fI33E7aKAWNapoAGISiAkVTRovWT6XBDsY6Xd4oI=
Authentication-Results: mxback7o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id xh91ISbyMU-50R4I3Ss;
        Fri, 22 Mar 2019 04:05:00 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: Re: [PATCH V2 2/2] Input: rotaty-encoder - Add DT binding
 document
To:     Rob Herring <robh@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Donghoon Han <nazgul33@gmail.com>, linux-input@vger.kernel.org,
        Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20190107164249.2342-1-nazgul33@gmail.com>
 <20190107164249.2342-3-nazgul33@gmail.com> <20190115035221.GA151157@dtor-ws>
 <20190115202948.GA26482@bogus>
From:   Alexey Slepov <sir-lexa@yandex.ru>
Message-ID: <f780ef34-474b-3e23-b495-f2e80e87c18b@yandex.ru>
Date:   Fri, 22 Mar 2019 02:04:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115202948.GA26482@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i used this rotary-encoder patch in my embedded project and found two 
errors:


First, in drivers/input/misc/rotary_encoder.c,
at @@ -237,6 +244,16 @@:
instead of

+        if (err)
+            dev_err(dev, "unable to get keycodes: %d\n", err);
+        return err;

it must be

+        if (err) {
+            dev_err(dev, "unable to get keycodes: %d\n", err);
+            return err;
+        }

otherwise successful creation of device is not possible.


Second, a typo in 
Documentation/devicetree/bindings/input/rotary-encoder.txt,
at @@ -48,3 +52,11 @@:
instead of

+            rotary-encoder,relative-keycode = <103>, <108>;

it should be

+            rotary-encoder,relative-keycodes = <103>, <108>;

otherwise keycodes are not found.


I am sorry, I know that E-Mail style is not good.
I have no time right now, but I'll be back in two weeks.
Someone, maybe Mr. Han, could submit a new version of the patch.
If not, I'll try to do it on my return. (it could take some time, since 
I am new to patchwork)

Best Regards and thanks
Alexey Slepov
