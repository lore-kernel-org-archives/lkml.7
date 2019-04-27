Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA40C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169EB2146E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556370309;
	bh=G9GihYyPlWfSV3q9+hbppzaYaJqdcPysBlWJcOlntGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FGVxgDp75ck7HecKEGYoHqDZnSaKsjLFMZVmC8RZy+1nItvxupejlFQzTKzl6XWAB
	 yA9LIEiTr6//bK6/dG1EH1GAEYsEier59LChi5A4Bs6vJ0Q1XQ8EMw6Rp6VIZ974TD
	 QtaOQqAGBolr/KZCNFvurQVGlf2X+C1ySzSwO9ao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfD0NFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 09:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfD0NFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 09:05:07 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20D372087C;
        Sat, 27 Apr 2019 13:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556370307;
        bh=G9GihYyPlWfSV3q9+hbppzaYaJqdcPysBlWJcOlntGs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g4BdpAb6uTuKWBzdTHy8Fhg0zZlm1nC4kns6XIVS3SLrA3g7bfMZ0f3RnTxpBJ+/u
         B0jbnDYIg6iVz0IDOTWTZ0W6pK1SheiddnelEyPHd+4++7Ip/G/HjJ1kNk4ZXFHGgO
         PC+nXAYZfcfALYVMp5wz3T+7/0WBEOBgetB99Jwk=
Date:   Sat, 27 Apr 2019 14:05:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Brian Masney <masneyb@onstation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: tsl2772: convert bindings to
 YAML format
Message-ID: <20190427140501.430cfc0c@archlinux>
In-Reply-To: <CAL_JsqL0SQZSs8MmF6j1B_qfvCOcg9XMjUBUHFL+mnCk7xNB1A@mail.gmail.com>
References: <20190425230314.26000-1-masneyb@onstation.org>
        <CAL_JsqL0SQZSs8MmF6j1B_qfvCOcg9XMjUBUHFL+mnCk7xNB1A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019 08:20:34 -0500
Rob Herring <robh+dt@kernel.org> wrote:

> On Thu, Apr 25, 2019 at 6:03 PM Brian Masney <masneyb@onstation.org> wrote:
> >
> > Convert the tsl2772 device tree bindings to the new YAML format.
> >
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > ---
> > Changes since v2:
> > - Remove allof from led-max-microamp. Split out enum list from [] to
> >   individual lines for consistency with the compatible attribute.
> > - Change 'proximity-sensor@39' in example to 'sensor@39'.
> >
> > Changes since v1:
> > - Dropped description from reg and interrupts properties.
> > - Dropped $ref from led-max-microamp, vdd-supply, and vddio-supply.
> > - Changed 'tsl2772@39' in example to 'proximity-sensor@39'
> >
> >  .../devicetree/bindings/iio/light/tsl2772.txt | 42 ----------
> >  .../bindings/iio/light/tsl2772.yaml           | 83 +++++++++++++++++++
> >  2 files changed, 83 insertions(+), 42 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.yaml  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied.  Thanks,

Jonathan


