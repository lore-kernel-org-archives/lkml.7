Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46658C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1286E20657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505908;
	bh=rfkW1Xv7uiiz6cELg2hTaWNDQDofEY5onB7og4LYjL0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bh321NkzZorcuRfDifVPWJCrPld4vtUr6Yu/aRzJwVpff1u7zA/FSHc6dHGX2EjAf
	 mcOxEsCjHGspYyXFGz/1snqzcMy6LN26Y+KtAb7Uszqpj5hQh1qsfvRi9ZzpnWv0rC
	 ih6wPc5h+a0xhlqxygFWMGuCdAGJz3PpixzqW0A0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfCMTi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbfCMTiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:38:25 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45B152146E;
        Wed, 13 Mar 2019 19:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552505904;
        bh=rfkW1Xv7uiiz6cELg2hTaWNDQDofEY5onB7og4LYjL0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VNqxZNoX/tmjldTjbiVqIBqVEqzZbs/9QCYs8bu12rPvQMlPzhJp0W3kyMMWGLsxR
         TG3s+TnSU+rIu9bYznxh6QTfTP+oite3YahPnXqDe2KlqzpDBfFF6ucez3mWri39Fy
         Ce7p4amRDAM8oIpvZ+NUmIrikZjnYV/Hv6DyCBD4=
Received: by mail-qt1-f177.google.com with SMTP id f11so3351349qti.7;
        Wed, 13 Mar 2019 12:38:24 -0700 (PDT)
X-Gm-Message-State: APjAAAW62rNFztoeomF9l3v/AklNOGaBM7CBDpRylDSkuiuvTUWMHFB6
        XoP5Vkqjo6ND1TeyedszGHXttX1bRIVyOBmdzA==
X-Google-Smtp-Source: APXvYqwIetk0zspsXDDhcayXuDinYxCVAuoPtcUNjsb0VEPbaJUH6x0tMSPXqt17XD5PTQlPFlKpiBCXV0UF9q+ick8=
X-Received: by 2002:ac8:267c:: with SMTP id v57mr8108412qtv.76.1552505903477;
 Wed, 13 Mar 2019 12:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190302090505.65542-1-chenyu56@huawei.com> <20190302090505.65542-2-chenyu56@huawei.com>
 <20190312134525.GA9706@bogus> <594394e2-c399-39db-979a-fadb17ef28df@huawei.com>
In-Reply-To: <594394e2-c399-39db-979a-fadb17ef28df@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Mar 2019 14:38:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKUCBcKOjaU9WMUjzKtOALAJDpVABbRJLeFTNk3bM5oVA@mail.gmail.com>
Message-ID: <CAL_JsqKUCBcKOjaU9WMUjzKtOALAJDpVABbRJLeFTNk3bM5oVA@mail.gmail.com>
Subject: Re: [PATCH v3 01/12] dt-bindings: phy: Add support for HiSilicon's
 hi3660 USB PHY
To:     Chen Yu <chenyu56@huawei.com>
Cc:     liuyu712@hisilicon.com, Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>, kongfei@hisilicon.com,
        wanghu17@hisilicon.com, butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com,
        Li Pengcheng <lipengcheng8@huawei.com>,
        Song Xiaowei <songxiaowei@hisilicon.com>,
        Yiping Xu <xuyiping@hisilicon.com>, xuyoujun4@huawei.com,
        yudongbin@hisilicon.com, zangleigang <zangleigang@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 8:40 PM Chen Yu <chenyu56@huawei.com> wrote:
>
> Hi Rob,
>
> On 2019/3/12 21:45, Rob Herring wrote:
> > On Sat, Mar 02, 2019 at 05:04:54PM +0800, Yu Chen wrote:
> >> This patch adds binding documentation for supporting the hi3660 usb
> >> phy on boards like the HiKey960.
> >>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: John Stultz <john.stultz@linaro.org>
> >> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> >> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> >> ---
> >> v1:
> >> * Fix some format error as suggested by Rob.
> >> v2:
> >> * Change hi3660 usb PHY to hi3660 USB PHY
> >> v3:
> >> * Make device node a subnode of usb3_otg_bc register.
> >> ---
> >> ---
> >>  .../devicetree/bindings/phy/phy-hi3660-usb3.txt    | 28 ++++++++++++++++++++++
> >>  1 file changed, 28 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt b/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
> >> new file mode 100644
> >> index 000000000000..6096214a2bc6
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
> >> @@ -0,0 +1,28 @@
> >> +Hisilicon hi3660 USB PHY
> >> +-----------------------
> >> +
> >> +Required properties:
> >> +- compatible: should be "hisilicon,hi3660-usb-phy"
> >> +- #phy-cells: must be 0
> >> +- hisilicon,pericrg-syscon: phandle of syscon used to control phy.
> >> +- hisilicon,pctrl-syscon: phandle of syscon used to control phy.
> >> +- hisilicon,usb3-otg-bc-syscon: phandle of syscon used to control phy.
> >
> > You can drop this as it is now just the parent node.
> >
> >> +- hisilicon,eye-diagram-param: parameter set for phy
> >> +Refer to phy/phy-bindings.txt for the generic PHY binding properties
> >> +
> >> +This is a subnode of usb3_otg_bc register node.
> >> +
> >> +Example:
> >> +    usb3_otg_bc: usb3_otg_bc@ff200000 {
> >> +            compatible = "syscon", "simple-mfd";
> >
> > This node should have a specific compatible.
> >
> Do you mean I need write a specific driver for this node ?

No, only that you could if needed in the future. You can still use the
fallbacks for now.

Rob
