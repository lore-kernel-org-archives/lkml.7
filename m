Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4412C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845BE2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="nbwNcHbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbfDDVF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:05:26 -0400
Received: from mout.web.de ([212.227.17.12]:56515 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729116AbfDDVFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554411905;
        bh=gCZDr22E611CAUSTotJm2YNoKYzpir4Q5kjNumP+x4k=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=nbwNcHboxngitpBPOm2mThwIO8vjaaA5oAoQuc6GDxYokbLaNU2ShUCtdE19Y5nMF
         J+lzyzbOjICwMpG+y1Y5ilfQFQ3GekqckU1UDqp4L2llyI4cZ990p44cLUw6bxuy+8
         OuT8eLy7nU3BqnP/IKRIy5ZJzOZZze3Jz8yL05H4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.54.132]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MeSGJ-1hYuAI2Wzf-00QEVZ; Thu, 04
 Apr 2019 23:05:05 +0200
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Yi Wang <wang.yi59@zte.com.cn>
References: <1554307455-40361-6-git-send-email-wen.yang99@zte.com.cn>
Subject: Re: [PATCH 5/7] drm/pl111: fix possible object reference leak
To:     Wen Yang <wen.yang99@zte.com.cn>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <439634be-1704-703f-f975-98909b950224@web.de>
Date:   Thu, 4 Apr 2019 23:05:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554307455-40361-6-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:cgQhxgQsc4FWBbYqhknUEKRXzm/SLBCVKSVDfioqaQMxeIMjda8
 w5XK5a2tLssaSW8KELyq/eT4GvaKFCNEs6chIkZtKD+BUlgY4dYoxekmRsoEU6DueioibNt
 RVZosGytLajAdPM7qqFxEMZwz0lNONutgUOEjk3tGpkW0ue/l3JpgiZ/6VwV9WmMCcSN2eR
 IbiOw0gigrhujmgOzsjpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WwlRKR+FErc=:pQ3UTiw9OCgwgCjZep7iYz
 jf7OJwN6Ti4zS2wak+qaQr3sbHzlf/JRVLVakFMdp19CYAYuKJPgNxYE3qd4m/BtunHQVO7js
 TmESxXqQFm2t7U6zQGHVyHi4tiDDr13ReZFMLH4U/VFhhZMCCnvslWx1NaJqMWtqRIBsGawKI
 1T0JpYuzsrqocahRXRHWpWGbO7IhZFWYsaOJ72GcFaWfO3u7Cu/VkyUEyJMHSfE6EUck7xWhW
 LvzUI8ghPixp01bu9WtGxRPqQKl9oQd8qK+uafkYgRPCdJcSBKT+V3tXKdpdrwU4huSUeKSJf
 7K+E4tBhSlVyrIOhoCL8EOC3vbK5qeJtIxFBI0j55LHQvLpScciD7tiL+UqBYIp+5QIHFJJC+
 nzzKLpTKm9SMi9dBOgI6gOtEZFurGQtYTOLGO2vTbJ1ICpUu+oz3tjHlUsVuqSPgP0k1/lbGc
 ozme/SNGWAUniVz7A9AGSAmvlCGuH0C3BTmjNPtrYU6kVmGPn6DIglaa6muFE4jfPTSxFTO/F
 SIlOYvoLHsFbvglCrDIVn5gf+fNnFCQ+ZKen1SJCpZLfAU/Udq2F1NHX68McxhcCQ4e7lIBAK
 jHi969HuGuBTmqbmGxrtv7c5jP4jH1GV/QUuZ1NpOSr0cBivO9vpPjIbyfHfZoArA4P8t+EgX
 fAi4NfL2BShXyVY8v1Qh1XxMQBg06xt1lQmXtxS9snWYbERp1K7lEoJ1K31Ehb+1Ysr6EBgc/
 dP2+a8K9bHHzL950lz8dGyOtIx4jwG/WNwcz1g4AbWm1vPrCjkq8sspUMaQmF5kc3NC93j5zz
 C5W8Y55+Xe3o2PYRZHh/5Bc22a+G4qVDS+6WnOWOV+qd41UURn1scbng6H6KFKSmgt0fb2xgJ
 dMa2BjLGR1hyUK7rimBHWO6b4wSmhrDeTDcY97ByScsaW5H+Nt0qPajJb0c8HfVxvoLuFpdgI
 X5Lwe0xN4fg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -337,17 +338,20 @@ int pl111_versatile_init(struct device *dev, struct pl111_drm_dev_private *priv)
>  		pdev = of_find_device_by_node(np);
>  		if (!pdev) {
>  			dev_err(dev, "can't find the sysreg device, deferring\n");
> +			of_node_put(np);
>  			return -EPROBE_DEFER;
>  		}
>  		map = dev_get_drvdata(&pdev->dev);
>  		if (!map) {
>  			dev_err(dev, "sysreg has not yet probed\n");
>  			platform_device_put(pdev);
> +			of_node_put(np);
>  			return -EPROBE_DEFER;
>  		}

How do you think about to move duplicate statements to an additional
jump target for the desired exception handling?

Regards,
Markus
