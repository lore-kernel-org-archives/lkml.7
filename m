Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47344C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0ED2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639575;
	bh=7HmkXOI4MwlMqzoTXHQ940g51qeofzyUIt+4PDo6JN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=If6GaraUhcKAURthEdrRY5GBj4UEV3CjAVTDlp6TcEMiUInXq22CBPRs5ugpXDWkd
	 C1G8sHYLmv+XOaJe39rFXn/wY16KBtHhTl6vj+aYD24s1ro20BRly5hgDI7sEuL9fA
	 ID+waD/USE2NHP2HiMxmLLnrHd6M1m6939HhPuIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391298AbfEWT0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:26:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390600AbfEWT0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:26:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D546221841;
        Thu, 23 May 2019 19:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639570;
        bh=7HmkXOI4MwlMqzoTXHQ940g51qeofzyUIt+4PDo6JN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1fM3PZ5owub46W5F85k29tav7hZF+GHYuZ0S0HQhr532Mv3zQcQLd/ej59ebby2xB
         cafy6jjdW5AiRz4XJuXHcELThFQLWeKBmYD4Anp6pSgHM1ypWe36mYO/Z9K7lY9Eem
         wEb6/mzHzQyaI20oh/Ijel41ChrOeE8eaWJU/zjs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Pirko <jiri@mellanox.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 014/122] mlxsw: core: Prevent QSFP module initialization for old hardware
Date:   Thu, 23 May 2019 21:05:36 +0200
Message-Id: <20190523181706.827541346@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Pasternak <vadimp@mellanox.com>

[ Upstream commit c52ecff7e6439ca8c9b03282e8869a005aa94831 ]

Old Mellanox silicons, like switchx-2, switch-ib do not support reading
QSFP modules temperature through MTMP register. Attempt to access this
register on systems equipped with the this kind of silicon will cause
initialization flow failure.
Test for hardware resource capability is added in order to distinct
between old and new silicon - old silicons do not have such capability.

Fixes: 6a79507cfe94 ("mlxsw: core: Extend thermal module with per QSFP module thermal zones")
Fixes: 5c42eaa07bd0 ("mlxsw: core: Extend hwmon interface with QSFP module temperature attributes")
Reported-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c         |    6 ++++++
 drivers/net/ethernet/mellanox/mlxsw/core.h         |    2 ++
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c   |    3 +++
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |    6 ++++++
 4 files changed, 17 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -122,6 +122,12 @@ void *mlxsw_core_driver_priv(struct mlxs
 }
 EXPORT_SYMBOL(mlxsw_core_driver_priv);
 
+bool mlxsw_core_res_query_enabled(const struct mlxsw_core *mlxsw_core)
+{
+	return mlxsw_core->driver->res_query_enabled;
+}
+EXPORT_SYMBOL(mlxsw_core_res_query_enabled);
+
 struct mlxsw_rx_listener_item {
 	struct list_head list;
 	struct mlxsw_rx_listener rxl;
--- a/drivers/net/ethernet/mellanox/mlxsw/core.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.h
@@ -28,6 +28,8 @@ unsigned int mlxsw_core_max_ports(const
 
 void *mlxsw_core_driver_priv(struct mlxsw_core *mlxsw_core);
 
+bool mlxsw_core_res_query_enabled(const struct mlxsw_core *mlxsw_core);
+
 int mlxsw_core_driver_register(struct mlxsw_driver *mlxsw_driver);
 void mlxsw_core_driver_unregister(struct mlxsw_driver *mlxsw_driver);
 
--- a/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c
@@ -518,6 +518,9 @@ static int mlxsw_hwmon_module_init(struc
 	u8 width;
 	int err;
 
+	if (!mlxsw_core_res_query_enabled(mlxsw_hwmon->core))
+		return 0;
+
 	/* Add extra attributes for module temperature. Sensor index is
 	 * assigned to sensor_count value, while all indexed before
 	 * sensor_count are already utilized by the sensors connected through
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -740,6 +740,9 @@ mlxsw_thermal_modules_init(struct device
 	struct mlxsw_thermal_module *module_tz;
 	int i, err;
 
+	if (!mlxsw_core_res_query_enabled(core))
+		return 0;
+
 	thermal->tz_module_arr = kcalloc(module_count,
 					 sizeof(*thermal->tz_module_arr),
 					 GFP_KERNEL);
@@ -776,6 +779,9 @@ mlxsw_thermal_modules_fini(struct mlxsw_
 	unsigned int module_count = mlxsw_core_max_ports(thermal->core);
 	int i;
 
+	if (!mlxsw_core_res_query_enabled(thermal->core))
+		return;
+
 	for (i = module_count - 1; i >= 0; i--)
 		mlxsw_thermal_module_fini(&thermal->tz_module_arr[i]);
 	kfree(thermal->tz_module_arr);


