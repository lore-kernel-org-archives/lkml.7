Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFB1C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0719320835
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556728037;
	bh=QNpnCPkV3/b0tnrMUodSGF1+h/20QEARntDWcAUOpKM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XE0BZ9I1PtBvpvq782987I0WSCkeEX7fWvoLaNoaNhsw7iCvvtAj8xPT15fJlUa3Y
	 qbhPkElfrQgb0CGlrX8/YsdcYyrHqJH1+TQkLZg79mNQoBHVD7RM9s9sQQGRsDPogN
	 u2EyhHlLXUDewbYtXqQTDimX0/9K0DC9gHaobztI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfEAQ1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbfEAQ1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:27:15 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2CA520835;
        Wed,  1 May 2019 16:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556728034;
        bh=QNpnCPkV3/b0tnrMUodSGF1+h/20QEARntDWcAUOpKM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sqp5SVDa4nhuGj8W5aMwN2LXkCdkQZqPMRHJ0VE6EbJWrWjaF0XZGB7QCW274ngeN
         zt8SRq8ojVn1IhRh/oZ3E0Wy07Izd3E5uDkZWFr/uBGJsx4yPe5DgRGTm9sOupSDwM
         ntW4IqK7hZ0hGVZgH9EWQzCtWQeGNe8R7Kt7YyZc=
Received: by mail-qk1-f169.google.com with SMTP id d5so10443998qko.12;
        Wed, 01 May 2019 09:27:13 -0700 (PDT)
X-Gm-Message-State: APjAAAW4DateloU5ER4cMe3XJxfJjHjGZTmVwvD/o38ts8iLpVZFsGff
        T4iT3mnuLUigZU3lOHwcg0JPUoolr1VqZA+U3Q==
X-Google-Smtp-Source: APXvYqyCXQr3u7uAxcUVOILBuMuhFCX+sPtcLyuqXIgJyVLjwYMn8i16UWe/OA76g5f5zMY/VN+/wMpT65IW9JfEWjg=
X-Received: by 2002:a37:4711:: with SMTP id u17mr19046164qka.326.1556728033039;
 Wed, 01 May 2019 09:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190420064019.57522-1-chenyu56@huawei.com> <20190420064019.57522-3-chenyu56@huawei.com>
 <20190425213532.GA32028@bogus> <f925304a-17ef-1574-b671-77d4ad0331d8@huawei.com>
In-Reply-To: <f925304a-17ef-1574-b671-77d4ad0331d8@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 1 May 2019 11:27:01 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Xf===cii0me0pwjZ2mcxXmYXDjNH7UpOftUphHCxd1w@mail.gmail.com>
Message-ID: <CAL_Jsq+Xf===cii0me0pwjZ2mcxXmYXDjNH7UpOftUphHCxd1w@mail.gmail.com>
Subject: Re: [PATCH v6 02/13] dt-bindings: misc: Add bindings for HiSilicon
 usb hub and data role switch functionality on HiKey960
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
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 1:08 AM Chen Yu <chenyu56@huawei.com> wrote:
>
> Hi Rob,
>
> On 2019/4/26 5:35, Rob Herring wrote:
> > On Sat, Apr 20, 2019 at 02:40:08PM +0800, Yu Chen wrote:
> >> This patch adds binding documentation to support usb hub and usb
> >> data role switch of Hisilicon HiKey960 Board.
> >
> > Sorry I've been slow to really review this, but I needed to look at the
> > schematics to see what exactly is going on here.
> >
> > I think this needs some changes to better reflect the h/w and utilize
> > existing bindings. It should really be designed ignoring the muxing to
> > start with. Define the binding for the TypeC connector and then the host
> > hub and make sure they can coexist. Then overlay what you need to switch
> > between the 2 modes which AFAICT is just a single GPIO.
> >
> >>
> >> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> >> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: John Stultz <john.stultz@linaro.org>
> >> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> >> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> >> ---
> >> v1:
> >> * Fix some format errors as suggested by Sergei.
> >> * Modify gpio description to use gpiod API.
> >> v2:
> >> * Remove information about Hikey.
> >> * Fix gpio description.
> >> * Remove device_type of endpoint.
> >> v3:
> >> * Remove property typec-vbus-enable-val.
> >> * Add description of pinctrl-names.
> >> * Add example for "hisilicon,gpio-hubv1"
> >> * Add flag in gpiod properties.
> >> ---
> >> ---
> >>  .../bindings/misc/hisilicon-hikey-usb.txt          | 52 ++++++++++++++++++++++
> >>  1 file changed, 52 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
> >> new file mode 100644
> >> index 000000000000..422e844df719
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
> >> @@ -0,0 +1,52 @@
> >> +Support usb hub and usb data role switch of Hisilicon HiKey960 Board.
> >> +
> >> +-----------------------------
> >> +
> >> +Required properties:
> >> +- compatible: "hisilicon,gpio-hubv1","hisilicon,hikey960-usb"
> >> +- typec-vbus-gpios: gpio to control the vbus of typeC port
> >
> > This should be a gpio regulator and then connected to 'vbus-supply' in a
> > usb-connector node (see .../bindings/connectors/usb-connector.txt).
> Currently usb-connector node has no "vbus-supply" property and
> I do not find process that handles vbus-supply in RT1711H TypeC driver.

The patch[1] adding that is posted to the list and may not have landed yet.

Whether the RT1711H TypeC driver handles it or not is not a binding problem.

> > Then you also need the RT1711HWSC TypeC controller in DT. That is
> > typically the parent device of the connector node.
> >
> >> +- otg-switch-gpios: gpio to switch DP & DM between the hub and typeC port
> >
> > This probably belongs in USB controller node.
> >
> The otg-switch-gpios controls a mux like fsusb30mux. It is related to
> the board design of HiKey960. And the state of the mux is decided by
> the typeC port state. So I think it is not so good to make it belongs
> in USB controller node.

Let me put it this way. The gpio property belongs wherever the mux is
represented. In this case, I would expect the graph port representing
the HS port to have 2 endpoints representing the 2 mux outputs. We
don't generally put properties in the endpoint or port nodes, but the
parent nodes.

> >> +- hub-vdd33-en-gpios: gpio to enable the power of hub
> >
> > This too should be a gpio regulator and then in a hub node. We have 2
> > ways to represent hubs. Either as an I2C device or as a child of the
> > host controller. The latter is preferred, but I'm not too sure how the
> > OF graph connection linking the controller to the TypeC connector will
> > work with the usb bus binding.
> >
> There is no particular code except the power control for the hub.
> The i2c on the hub is not used. So it can not be an I2C device.
> Is there such an example that make the hub as a child of the host controller
> and control its power?

Yes, bindings/usb/usb-device.txt.

Rob

[1] https://www.spinics.net/lists/kernel/msg3089136.html
