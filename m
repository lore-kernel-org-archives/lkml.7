Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0721CC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 15:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD86B20679
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 15:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2GbMAGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfFVPXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 11:23:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41465 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfFVPXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 11:23:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so5069501pff.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 08:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=GPTSxD3SoJJYK/xNju7R95QIb8W/tbtt9nogyltuHKI=;
        b=i2GbMAGmEqn1FEhmuQIzC8R4PZBkb57Nq/tMdcdhltwWXrJoPQLVNRVA4JQYAQFwin
         IDN/J2kcEauj6qdhcGjIZtDXeFXoFzvv7986vWoSWE1d31OCX0qD+UrLb2037FubK7ZA
         izxfLqm/bhP9yrfjKD4Bm0bNhCCBnN7DcgjCsf1GEiIx4vvOehTQF5o5Z1KAkuBEuwgF
         YqBNNbG1i8BkqGX6DO7gpec74/s6+nBnT0hD34eUiLcUwlqYmKU1UNg1+KfQF74q+jkA
         5uIrLR9yr6dtUp3SeysaZh0RnOgdppSxEWsP3IgfHWpOCHBLyNeAt+AUXSFNJqfYI8t6
         be4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=GPTSxD3SoJJYK/xNju7R95QIb8W/tbtt9nogyltuHKI=;
        b=VzOlHdETc2CxhKMJZgnkJeUM9O6NCS70w8xk2sWJP1+eC+uRBYvBmIxz38NFa0+lLy
         U+zZQVfGqvSgBt8qoejXivIabU4hDLXT07SSsgJtDhnAUBcXg6/tcZGezBs97yge+55Y
         XyT0+6Zz+RMd7br9r71WXuQ50yR2qCsvzxrveUS0/JdIo0H1OrsjntMyCPMXKA+HEouQ
         YTuQ2vfO5+knpL5HeYvPj0M48UYE0+DZiGPevVlMhqyBi9KUSrfwCmn/Y4k6IuazsB+X
         xwsTvQcRKeze71veuguUddV6KgCWTThV9OyHQynytEbDLEHJ6o1rfmMVs3xM+5TpN5HY
         hDYA==
X-Gm-Message-State: APjAAAWY3zH8Aqh+a/blYpPFHzhZXsBCLANzRbAMdy1GmS51LrI+jcPq
        8oi6oXsL2Zm9YbbZ4RTJ9Ko=
X-Google-Smtp-Source: APXvYqymA3yN0jS/j3O3H11EeqM2fFBKrp9PzSnPWeIQ8ZRd2SMZ6XYTKv00yPMwn100vITjLj42rg==
X-Received: by 2002:a17:90a:2430:: with SMTP id h45mr14093490pje.14.1561217030491;
        Sat, 22 Jun 2019 08:23:50 -0700 (PDT)
Received: from localhost.localdomain (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id l44sm12496777pje.29.2019.06.22.08.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 22 Jun 2019 08:23:50 -0700 (PDT)
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Shobhit Kukreti <shobhitkukreti@gmail.com>
Subject: [PATCH 1/2] staging: rtl8723bs: os_dep: Modify return type of function loadparam(..) to void
Date:   Sat, 22 Jun 2019 08:23:07 -0700
Message-Id: <7ca00f90afa0cfa4acfe1ca5dd984a8a1083fe1a.1561215416.git.shobhitkukreti@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1561215416.git.shobhitkukreti@gmail.com>
References: <cover.1561215416.git.shobhitkukreti@gmail.com>
In-Reply-To: <cover.1561215416.git.shobhitkukreti@gmail.com>
References: <cover.1561215416.git.shobhitkukreti@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function static uint loadparam(struct adapter *padapter, _nic_hdl
pnetdev) return type is modified to void.
The initial return value was always returning _SUCCESS and the return value
is never checked when the function is called. 
This resolves coccicheck warnings of unneeded variables.

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 8a9d838..bd8e316 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -223,9 +223,8 @@ int _netdev_open(struct net_device *pnetdev);
 int netdev_open (struct net_device *pnetdev);
 static int netdev_close (struct net_device *pnetdev);
 
-static uint loadparam(struct adapter *padapter, _nic_hdl pnetdev)
+static void loadparam(struct adapter *padapter, _nic_hdl pnetdev)
 {
-	uint status = _SUCCESS;
 	struct registry_priv  *registry_par = &padapter->registrypriv;
 
 	registry_par->chip_version = (u8)rtw_chip_version;
@@ -330,7 +329,6 @@ static uint loadparam(struct adapter *padapter, _nic_hdl pnetdev)
 	registry_par->qos_opt_enable = (u8)rtw_qos_opt_enable;
 
 	registry_par->hiq_filter = (u8)rtw_hiq_filter;
-	return status;
 }
 
 static int rtw_net_set_mac_address(struct net_device *pnetdev, void *p)
-- 
2.7.4

