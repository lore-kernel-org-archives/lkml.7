Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB39CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BD620830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfDCRLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:11:06 -0400
Received: from smtprelay0171.hostedemail.com ([216.40.44.171]:46299 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726097AbfDCRLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:11:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id E7542181D3377;
        Wed,  3 Apr 2019 17:11:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: soda09_432e6ea23995f
X-Filterd-Recvd-Size: 2565
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Wed,  3 Apr 2019 17:11:01 +0000 (UTC)
Message-ID: <1ed5eb3af4df6b2dd1544c7b696e034ed5c94f06.camel@perches.com>
Subject: Re: [PATCH v5 0/3] drm/panel: Support Rocktech jh057n00900 DSI panel
From:   Joe Perches <joe@perches.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Date:   Wed, 03 Apr 2019 10:11:00 -0700
In-Reply-To: <20190403161735.GN5238@ulmo>
References: <cover.1554114302.git.agx@sigxcpu.org>
         <20190403161735.GN5238@ulmo>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-03 at 18:17 +0200, Thierry Reding wrote:
> On Mon, Apr 01, 2019 at 12:35:32PM +0200, Guido Günther wrote:
> > v4 fixes up the DT binding example and uses a wider cc list since I
> > failed to extend that when touching more files.
[]
> Applied, thanks.
> 
> checkpatch does complain about the dsi_generic_write_seq() macro
> definition, because it uses flow control statements, but there are
> already similar macros in other drivers, so I let this slide. We may
> want to eventually come up with something better and then replace these
> macros for the other drivers as well.

Dunno about the other drivers, but the mechanism isn't
particularly nice as it separates the init identifier
from the data being written.

It might be better to use something like a struct for
each command and a for loop for each block of commands.

Also the 0xBF value used in one of the init sequence
writes does not have an identifier #define in the
'Manufacturer specific Commands send via DSI' block
which is odd.


