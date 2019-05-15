Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E6AC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDCA2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEOJgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:36:41 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:38221 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725871AbfEOJgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:36:40 -0400
X-UUID: d2ad90e0f7144a55aa61dc3e5dba771f-20190515
X-UUID: d2ad90e0f7144a55aa61dc3e5dba771f-20190515
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 110671046; Wed, 15 May 2019 17:36:36 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 15 May
 2019 17:36:34 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 15 May 2019 17:36:33 +0800
Message-ID: <1557912993.10179.306.camel@mhfsdcap03>
Subject: Re: [PATCH v5 2/6] dt-bindings: usb: add binding for Type-B GPIO
 connector driver
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        "Badhri Jagan Sridharan" <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 May 2019 17:36:33 +0800
In-Reply-To: <20190514181204.GA13949@bogus>
References: <1557823643-8616-1-git-send-email-chunfeng.yun@mediatek.com>
         <1557823643-8616-3-git-send-email-chunfeng.yun@mediatek.com>
         <20190514181204.GA13949@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-14 at 13:12 -0500, Rob Herring wrote:
> On Tue, May 14, 2019 at 04:47:19PM +0800, Chunfeng Yun wrote:
> > It's used to support dual role switch via GPIO when use Type-B
> > receptacle, typically the USB ID pin is connected to an input
> > GPIO pin
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> > v5 changes:
> >  1. treat type-B connector as child device of USB controller's, but not
> >     as a separate virtual device, suggested by Rob
> >  2. put connector's port node under connector node, suggested by Rob
> > 
> > v4 no changes
> > 
> > v3 changes:
> >  1. treat type-B connector as a virtual device, but not child device of
> >     USB controller's
> > 
> > v2 changes:
> >   1. new patch to make binding clear suggested by Hans
> > ---
> >  .../bindings/usb/typeb-conn-gpio.txt          | 42 +++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/typeb-conn-gpio.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/typeb-conn-gpio.txt b/Documentation/devicetree/bindings/usb/typeb-conn-gpio.txt
> > new file mode 100644
> > index 000000000000..20dd3499a348
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/typeb-conn-gpio.txt
> > @@ -0,0 +1,42 @@
> > +USB Type-B GPIO Connector
> > +
> > +This is used to switch dual role mode from the USB ID pin connected to
> > +an input GPIO pin.
> > +
> > +Required properties:
> > +- compatible : should include "linux,typeb-conn-gpio" and "usb-b-connector".
> 
> I don't think we need "linux,typeb-conn-gpio". 
Not all usb-b-connector child node need bind this driver, by adding the
new compatible can avoid unnecessary binding.

> A driver can decide to 
> handle GPIO lines if they present
Yes, the driver, e.g. USB controller driver can do it, but here I want
to provide a common driver to handle this special case, like
extcon-usb-gpio driver does, and try to keep transparency from USB
controller driver. 

>  or we assume the parent device handles 
> ID and/or Vbus if they are not present.
Yes, it will
> 
> > +- id-gpios, vbus-gpios : either one of them must be present, and both
> > +	can be present as well.
> 
> Please clarify that vbus-gpios is an input to sense Vbus presence as an 
> output it should be modelled as a regulator only.
Ok, will add more description.
> 
> These should be added to usb-connector.txt.
Already add them in [1/6].
> 
> The result of all this is you don't need this file. Just additions to 
> usb-connector.txt.
Here add more constrains for id-gpios and vbus-gpios, at least one
should be present, although they are both optional, this is not true for
some cases, so not suitable to add into usb-connector.txt.
> 
> > +- vbus-supply : can be present if needed when supports dual role mode or
> > +	host mode.
> > +	see connector/usb-connector.txt
> > +
> > +Sub-nodes:
> > +- port : should be present.
> > +	see graph.txt
> > +
> > +Example:
> > +
> > +&mtu3 {
> > +	status = "okay";
> 
> Don't show status in examples.
Ok, will drop it.
> 
> > +
> > +	connector {
> > +		compatible = "linux,typeb-conn-gpio", "usb-b-connector";
> > +		label = "micro-USB";
> > +		type = "micro";
> > +		id-gpios = <&pio 12 GPIO_ACTIVE_HIGH>;
> > +		vbus-supply = <&usb_p0_vbus>;
> > +
> > +		port {
> > +			bconn_ep: endpoint@0 {
> > +				remote-endpoint = <&usb_role_sw>;
> > +			};
> > +		};
> > +	};
> > +
> > +	port {
> > +		usb_role_sw: endpoint@0 {
> > +			remote-endpoint = <&bconn_ep>;
> > +		};
> > +	};
> 
> When the host controller is the parent of the connector, you don't need 
> the graph unless you're describing the alternate modes in Type-C.
Ok, got it.

Thanks a lot.

> 
> > +};
> > -- 
> > 2.21.0
> > 


