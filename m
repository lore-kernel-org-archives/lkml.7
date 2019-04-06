Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0792EC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 10:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C954621855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 10:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDFKgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 06:36:15 -0400
Received: from retiisi.org.uk ([95.216.213.190]:47428 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726036AbfDFKgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 06:36:14 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id AB884634C7B;
        Sat,  6 Apr 2019 13:35:24 +0300 (EEST)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1hCifV-0001tz-9f; Sat, 06 Apr 2019 13:35:25 +0300
Date:   Sat, 6 Apr 2019 13:35:25 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Mickael Guene <mickael.guene@st.com>
Cc:     linux-media@vger.kernel.org, hugues.fruchet@st.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: Document MIPID02 bindings
Message-ID: <20190406103525.amfsljsz4twi3xq2@valkosipuli.retiisi.org.uk>
References: <1552373045-134493-1-git-send-email-mickael.guene@st.com>
 <1553680545-73278-1-git-send-email-mickael.guene@st.com>
 <1553680545-73278-2-git-send-email-mickael.guene@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553680545-73278-2-git-send-email-mickael.guene@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mickael,

On Wed, Mar 27, 2019 at 10:55:43AM +0100, Mickael Guene wrote:
> This adds documentation of device tree for MIPID02 CSI-2 to PARALLEL
> bridge.
> 
> Signed-off-by: Mickael Guene <mickael.guene@st.com>
> ---
> 
> Changes in v4:
> - Fix and clarify endpoints properties documentation
> 
> Changes in v3: None
> Changes in v2:
> - Add precision about first CSI-2 port data rate
> - Document endpoints supported properties
> - Rename 'mipid02@14' into generic 'csi2rx@14' in example
> 
>  .../bindings/media/i2c/st,st-mipid02.txt           | 82 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 ++
>  2 files changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/st,st-mipid02.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/st,st-mipid02.txt b/Documentation/devicetree/bindings/media/i2c/st,st-mipid02.txt
> new file mode 100644
> index 0000000..754a175
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/st,st-mipid02.txt
> @@ -0,0 +1,82 @@
> +STMicroelectronics MIPID02 CSI-2 to PARALLEL bridge
> +
> +MIPID02 has two CSI-2 input ports, only one of those ports can be active at a
> +time. Active port input stream will be de-serialized and its content outputted
> +through PARALLEL output port.
> +CSI-2 first input port is a dual lane 800Mbps per lane whereas CSI-2 second
> +input port is a single lane 800Mbps. Both ports support clock and data lane
> +polarity swap. First port also supports data lane swap.
> +PARALLEL output port has a maximum width of 12 bits.
> +Supported formats are RAW6, RAW7, RAW8, RAW10, RAW12, RGB565, RGB888, RGB444,
> +YUV420 8-bit, YUV422 8-bit and YUV420 10-bit.
> +
> +Required Properties:
> +- compatible: should be "st,st-mipid02"

s/should/shall/ overall; other values aren't really valid in any of the
cases.

-- 
Sakari Ailus
