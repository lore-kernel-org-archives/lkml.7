Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DDEC2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 10:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9C9206E4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 10:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfLaK3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 05:29:34 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:60229 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727130AbfLaK3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 05:29:31 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 31 Dec 2019 12:29:25 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id xBVATJ7c008518;
        Tue, 31 Dec 2019 12:29:25 +0200
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v1 5/9] platform/x86: mlx-platform: Set system mux configuration based on system type
Date:   Tue, 31 Dec 2019 10:29:13 +0000
Message-Id: <20191231102917.24181-6-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191231102917.24181-1-vadimp@mellanox.com>
References: <20191231102917.24181-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate assignment for systems mux configuration based on system type,
instead of setting the same configuration for the all.
The motivation is to allow introduction of new systems types with the
different mux topology.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/x86/mlx-platform.c | 46 ++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index 7e92dc52071f..0a41668b1587 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -219,7 +219,7 @@ static const int mlxplat_default_channels[][MLXPLAT_CPLD_GRP_CHNL_NUM] = {
 static const int mlxplat_msn21xx_channels[] = { 1, 2, 3, 4, 5, 6, 7, 8 };
 
 /* Platform mux data */
-static struct i2c_mux_reg_platform_data mlxplat_mux_data[] = {
+static struct i2c_mux_reg_platform_data mlxplat_default_mux_data[] = {
 	{
 		.parent = 1,
 		.base_nr = MLXPLAT_CPLD_CH1,
@@ -239,6 +239,11 @@ static struct i2c_mux_reg_platform_data mlxplat_mux_data[] = {
 
 };
 
+/* Platform mux configuration variables */
+static int mlxplat_max_adap_num;
+static int mlxplat_mux_num;
+static struct i2c_mux_reg_platform_data *mlxplat_mux_data;
+
 /* Platform hotplug devices */
 static struct i2c_board_info mlxplat_mlxcpld_psu[] = {
 	{
@@ -1905,7 +1910,10 @@ static int __init mlxplat_dmi_default_matched(const struct dmi_system_id *dmi)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(mlxplat_mux_data); i++) {
+	mlxplat_max_adap_num = MLXPLAT_CPLD_MAX_PHYS_ADAPTER_NUM;
+	mlxplat_mux_num = ARRAY_SIZE(mlxplat_default_mux_data);
+	mlxplat_mux_data = mlxplat_default_mux_data;
+	for (i = 0; i < mlxplat_mux_num; i++) {
 		mlxplat_mux_data[i].values = mlxplat_default_channels[i];
 		mlxplat_mux_data[i].n_values =
 				ARRAY_SIZE(mlxplat_default_channels[i]);
@@ -1924,7 +1932,10 @@ static int __init mlxplat_dmi_msn21xx_matched(const struct dmi_system_id *dmi)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(mlxplat_mux_data); i++) {
+	mlxplat_max_adap_num = MLXPLAT_CPLD_MAX_PHYS_ADAPTER_NUM;
+	mlxplat_mux_num = ARRAY_SIZE(mlxplat_default_mux_data);
+	mlxplat_mux_data = mlxplat_default_mux_data;
+	for (i = 0; i < mlxplat_mux_num; i++) {
 		mlxplat_mux_data[i].values = mlxplat_msn21xx_channels;
 		mlxplat_mux_data[i].n_values =
 				ARRAY_SIZE(mlxplat_msn21xx_channels);
@@ -1943,7 +1954,10 @@ static int __init mlxplat_dmi_msn274x_matched(const struct dmi_system_id *dmi)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(mlxplat_mux_data); i++) {
+	mlxplat_max_adap_num = MLXPLAT_CPLD_MAX_PHYS_ADAPTER_NUM;
+	mlxplat_mux_num = ARRAY_SIZE(mlxplat_default_mux_data);
+	mlxplat_mux_data = mlxplat_default_mux_data;
+	for (i = 0; i < mlxplat_mux_num; i++) {
 		mlxplat_mux_data[i].values = mlxplat_msn21xx_channels;
 		mlxplat_mux_data[i].n_values =
 				ARRAY_SIZE(mlxplat_msn21xx_channels);
@@ -1962,7 +1976,10 @@ static int __init mlxplat_dmi_msn201x_matched(const struct dmi_system_id *dmi)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(mlxplat_mux_data); i++) {
+	mlxplat_max_adap_num = MLXPLAT_CPLD_MAX_PHYS_ADAPTER_NUM;
+	mlxplat_mux_num = ARRAY_SIZE(mlxplat_default_mux_data);
+	mlxplat_mux_data = mlxplat_default_mux_data;
+	for (i = 0; i < mlxplat_mux_num; i++) {
 		mlxplat_mux_data[i].values = mlxplat_msn21xx_channels;
 		mlxplat_mux_data[i].n_values =
 				ARRAY_SIZE(mlxplat_msn21xx_channels);
@@ -1981,7 +1998,10 @@ static int __init mlxplat_dmi_qmb7xx_matched(const struct dmi_system_id *dmi)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(mlxplat_mux_data); i++) {
+	mlxplat_max_adap_num = MLXPLAT_CPLD_MAX_PHYS_ADAPTER_NUM;
+	mlxplat_mux_num = ARRAY_SIZE(mlxplat_default_mux_data);
+	mlxplat_mux_data = mlxplat_default_mux_data;
+	for (i = 0; i < mlxplat_mux_num; i++) {
 		mlxplat_mux_data[i].values = mlxplat_msn21xx_channels;
 		mlxplat_mux_data[i].n_values =
 				ARRAY_SIZE(mlxplat_msn21xx_channels);
@@ -1998,7 +2018,7 @@ static int __init mlxplat_dmi_qmb7xx_matched(const struct dmi_system_id *dmi)
 	mlxplat_regmap_config = &mlxplat_mlxcpld_regmap_config_ng;
 
 	return 1;
-}
+};
 
 static const struct dmi_system_id mlxplat_dmi_table[] __initconst = {
 	{
@@ -2127,7 +2147,7 @@ static int mlxplat_mlxcpld_verify_bus_topology(int *nr)
 	/* Scan adapters from expected id to verify it is free. */
 	*nr = MLXPLAT_CPLD_PHYS_ADAPTER_DEF_NR;
 	for (i = MLXPLAT_CPLD_PHYS_ADAPTER_DEF_NR; i <
-	     MLXPLAT_CPLD_MAX_PHYS_ADAPTER_NUM; i++) {
+	     mlxplat_max_adap_num; i++) {
 		search_adap = i2c_get_adapter(i);
 		if (search_adap) {
 			i2c_put_adapter(search_adap);
@@ -2141,12 +2161,12 @@ static int mlxplat_mlxcpld_verify_bus_topology(int *nr)
 	}
 
 	/* Return with error if free id for adapter is not found. */
-	if (i == MLXPLAT_CPLD_MAX_PHYS_ADAPTER_NUM)
+	if (i == mlxplat_max_adap_num)
 		return -ENODEV;
 
 	/* Shift adapter ids, since expected parent adapter is not free. */
 	*nr = i;
-	for (i = 0; i < ARRAY_SIZE(mlxplat_mux_data); i++) {
+	for (i = 0; i < mlxplat_mux_num; i++) {
 		shift = *nr - mlxplat_mux_data[i].parent;
 		mlxplat_mux_data[i].parent = *nr;
 		mlxplat_mux_data[i].base_nr += shift;
@@ -2202,7 +2222,7 @@ static int __init mlxplat_init(void)
 	if (nr < 0)
 		goto fail_alloc;
 
-	nr = (nr == MLXPLAT_CPLD_MAX_PHYS_ADAPTER_NUM) ? -1 : nr;
+	nr = (nr == mlxplat_max_adap_num) ? -1 : nr;
 	if (mlxplat_i2c)
 		mlxplat_i2c->regmap = priv->regmap;
 	priv->pdev_i2c = platform_device_register_resndata(
@@ -2215,7 +2235,7 @@ static int __init mlxplat_init(void)
 		goto fail_alloc;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(mlxplat_mux_data); i++) {
+	for (i = 0; i < mlxplat_mux_num; i++) {
 		priv->pdev_mux[i] = platform_device_register_resndata(
 						&priv->pdev_i2c->dev,
 						"i2c-mux-reg", i, NULL,
@@ -2349,7 +2369,7 @@ static void __exit mlxplat_exit(void)
 	platform_device_unregister(priv->pdev_led);
 	platform_device_unregister(priv->pdev_hotplug);
 
-	for (i = ARRAY_SIZE(mlxplat_mux_data) - 1; i >= 0 ; i--)
+	for (i = mlxplat_mux_num - 1; i >= 0 ; i--)
 		platform_device_unregister(priv->pdev_mux[i]);
 
 	platform_device_unregister(priv->pdev_i2c);
-- 
2.11.0

