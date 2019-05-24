Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608FDC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3198E21773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fLbTFdXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391279AbfEXSTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:19:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39833 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbfEXSTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:19:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so6047815wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 11:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+8J7+u+08zw/YayuZerzF4YvJ/C2JcgVQ3UZvTM8GdY=;
        b=fLbTFdXK/qHCokY3RRGYYjK9b5BKrl51TIo5xcbU/V1w71Dwmb7nnguqE/LlutxG0X
         jFWSeN4YebgtkduKqxhKCmUhJN71XPTkHNuphOwT+PhHlXGKEqoPjqr4vDenJW+pRhSr
         SwbGlSXdsq4MLZIC4tkbWx2U4Q56kzhih8EzIwaxMyzEubYKrtXsuvryQ5CqrEzKHEKW
         NYkdXaA+BQ/6nSc9CrC1OlIMNM5+CkferqlCSyzGNDD0MKPmGAqThxGX6gjZZy15Z7up
         Riq/QbxT1I2YIcTXhIKxqNKGD9wFJ+hN1Fq3s9VHiTRIJ95MEy/gHTjuhJzAFJyI2S6s
         oooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+8J7+u+08zw/YayuZerzF4YvJ/C2JcgVQ3UZvTM8GdY=;
        b=CoBm6/4usiScaAvRbnveDK6coQdnCkf50vl+Ng3wvNRKo92fs1wJ2TbVfz0XcfPbs2
         XUCvTVoRe8B/n8FtWdyfsQ0P6rvJoshYYRo37zXNamQ7yC1rLww0lFtIQNdxjVninRRv
         fHvv6qNy602FFZ/MR+W4oY2Ss5ngFuB+zWCUcvtTQ7mQkXVAioasLSUkMNDXgavmPwwy
         /L6hlC44Dio+mj6SQAJBtDCoeNFU8cb64NFr03+Ei4/ywfPvXyddw3dmzgFeXdky/yb6
         2TN1S8QoErFAtu1QxWf0ZcIFdCYGcFVfyttshOfJ0Ot9v8gFLQv+cVmKDNr3MtnORbHP
         K6XA==
X-Gm-Message-State: APjAAAVXSdazi0MD45ppRDjWn+++9Nkjs5daiBJMvjmOvujwIX8gpON4
        KPUR1WnF2lHlSKiDdmZexLI=
X-Google-Smtp-Source: APXvYqxqHSt7C6QxdYYFU1OJ2baCwFXbx4oAQnj+bTCBMrHIlPHQxmVND5il/ViRVFU8xUfrGuis/Q==
X-Received: by 2002:a7b:c40e:: with SMTP id k14mr895213wmi.114.1558721986483;
        Fri, 24 May 2019 11:19:46 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133EE7100D0AA8776F4474B72.dip0.t-ipconnect.de. [2003:f1:33ee:7100:d0aa:8776:f447:4b72])
        by smtp.googlemail.com with ESMTPSA id i15sm3181831wre.30.2019.05.24.11.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 11:19:45 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hexdump0815@googlemail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/1] ARM: meson8b-mxq: better support for the TRONFY MXQ
Date:   Fri, 24 May 2019 20:19:35 +0200
Message-Id: <20190524181936.29470-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A while ago a user asked on #linux-amlogic about the state of the
TRONFY MXQ in mainline. I did some research (mainly downloading an
Android firmware image for that device and looking at the .dtb) and
updated the mainline .dts accordingly.

I kept this patch in my tree but didn't hear back from anyone with one
of these boards (who could actually test my patch). That was until
today where I got the following message on IRC:
  any plans to submit your latest own version of the meson8b mxq dtb
  to mainline? it works really well for me and the one in mainline is
  too simple to be usedful ...

Thus I believe that this patch is finally ready for being included
upstream!


Martin Blumenstingl (1):
  ARM: dts: meson8b: mxq: improve support for the TRONFY MXQ S805

 arch/arm/boot/dts/meson8b-mxq.dts | 139 ++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

-- 
2.21.0

