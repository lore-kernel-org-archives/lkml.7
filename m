Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2F6C352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9DE206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfJGKAH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:00:07 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:53223 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfJGKAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:00:07 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 27EC7E0012;
        Mon,  7 Oct 2019 10:00:02 +0000 (UTC)
Date:   Mon, 7 Oct 2019 12:00:01 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/7] iio: adc: max1027: Add debugfs register read
 support
Message-ID: <20191007120001.61c8ef71@xps13>
In-Reply-To: <20191006110424.7781d99d@archlinux>
References: <20191003173401.16343-1-miquel.raynal@bootlin.com>
        <20191003173401.16343-2-miquel.raynal@bootlin.com>
        <20191006110424.7781d99d@archlinux>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Jonathan Cameron <jic23@kernel.org> wrote on Sun, 6 Oct 2019 11:04:24
+0100:

> On Thu,  3 Oct 2019 19:33:55 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Until now, only write operations were supported. Force two bytes read
> > operation when reading from this register (might be wrong when reading
> > the temperature, but will work with any other value).  
> 
> That's worrying as comments go.  Just return an error on the temperature
> register if it's going to do the wrong thing.

Actually the debugfs_reg_access hook is supposedly stateless. When
reading registers I don't know what I am reading because the "source" is
selected during the write operation, so I have no reliable way to know
what I am reading.

I set the read length to 2 bytes because most of the "atomic"reads are
two bytes and it allows us to test various commands directly from
userspace and read meaningful values. This is a limitation as:
* Voltage 'atomic' reads are 2 bytes
* Temperature 'atomic' reads are 2 bytes but never come alone (usually
  one voltage input of 2B will follow).
* Any other 'condensed' input will be more than 2 bytes, ie. several
  voltage values in one go.

In any case, doing a software reset of the chip will turn it back
into a working state no matter what was requested/read.

For me, 2-byte reads is a "good enough" solution that will work with
almost all the simplest ('atomic') SPI operations, but if you think
limiting to 2-bytes access is a problem (right now there is only write
access, which is kind of useless on its own) then let's drop the patch.
But I wanted to contribute it because it really helped me during the
development. 


Thanks,
Miquèl
