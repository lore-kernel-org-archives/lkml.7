Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A07C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 11:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C65621582
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 11:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgAELGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 06:06:14 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:33862 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgAELGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 06:06:13 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id AE11F20054;
        Sun,  5 Jan 2020 12:06:09 +0100 (CET)
Date:   Sun, 5 Jan 2020 12:06:07 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com, cawa.cheng@mediatek.com,
        bibby.hsieh@mediatek.com, linux-mediatek@lists.infradead.org,
        ck.hu@mediatek.com, stonea168@163.com
Subject: Re: [PATCH v7 0/8] add driver for "boe, tv101wum-nl6", "boe,
 tv101wum-n53", "auo, kd101n80-45na" and "auo, b101uan08.3" panels
Message-ID: <20200105110607.GA3309@ravnborg.org>
References: <20191012030720.27127-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012030720.27127-1-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=VwQbUJbxAAAA:8 a=QOvxnjmS4eJAzMLy2VwA:9 a=CjuIK1q_8ugA:10
        a=E9Po1WZjFZOl8hwRPBS3:22 a=AjGcO6oz07-iQ99wixmX:22
        a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jitao.

On Sat, Oct 12, 2019 at 11:07:12AM +0800, Jitao Shi wrote:
> Changes since v6:
>  - fix boe_panel_init err uninit.
>  - adjust the delay of backlight on.
> 
> Changes since v5:
>  - covert the documents to yaml
>  - fine tune boe, tv101wum-n53 panel video timine

I finally found some time to looks at this.

The bindings does unfortunately not pass a dt_binding_check

I had to locally do the following to make on of the bindings pass:
diff --git a/Documentation/devicetree/bindings/display/panel/auo,b101uan08.3.yaml b/Documentation/devicetree/bindings/display/panel/auo
,b101uan08.3.yaml
index c0939f8c7274..cafa870120fb 100644
--- a/Documentation/devicetree/bindings/display/panel/auo,b101uan08.3.yaml
+++ b/Documentation/devicetree/bindings/display/panel/auo,b101uan08.3.yaml
@@ -11,6 +11,9 @@ maintainers:
   - Sam Ravnborg <sam@ravnborg.org>
   - Rob Herring <robh+dt@kernel.org>

+allOf:
+  - $ref: panel-common.yaml#
+
 properties:
   compatible:
         const: auo,b101uan08.3
@@ -33,6 +36,8 @@ properties:
   backlight:
     description: phandle of the backlight device attached to the panel

+  port: true
+
 required:
  - compatible
  - reg
@@ -46,7 +51,9 @@ additionalProperties: false

 examples:
   - |
-    &dsi {
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
         panel@0 {
             compatible = "auo,b101uan08.3";
             reg = <0>;

I will follow-up with review feedback on the drivers later as time
permits.

	Sam



