Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C85ACA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEA621906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbfJWRnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:43:08 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:53866 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731112AbfJWRnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:43:08 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-128-127-nat.elisa-mobile.fi [85.76.128.127])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 02536B006F;
        Wed, 23 Oct 2019 20:43:04 +0300 (EEST)
Date:   Wed, 23 Oct 2019 20:43:04 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v2 0/5] Remove typedef declarations in
 staging: octeon
Message-ID: <20191023174304.GD18977@darkstar.musicnaut.iki.fi>
References: <cover.1570821661.git.wambui.karugax@gmail.com>
 <alpine.DEB.2.21.1910122034390.3049@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910122034390.3049@hadrien>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Oct 12, 2019 at 08:35:19PM +0200, Julia Lawall wrote:
> On Sat, 12 Oct 2019, Wambui Karuga wrote:
> > This patchset removes the addition of new typedefs data types in octeon,
> > along with replacing the previous uses with the new declaration format.
> >
> > v2 of the series removes the obsolete "_t" notation in the named types.
> >
> > Wambui Karuga (5):
> >   staging: octeon: remove typedef declaration for cvmx_wqe
> >   staging: octeon: remove typedef declaration for cvmx_helper_link_info
> >   staging: octeon: remove typedef declaration for cvmx_fau_reg_32
> >   staging: octeon: remove typedef declartion for cvmx_pko_command_word0
> >   staging: octeon: remove typedef declaration for cvmx_fau_op_size
> >
> >  drivers/staging/octeon/ethernet-mdio.c   |  6 +--
> >  drivers/staging/octeon/ethernet-rgmii.c  |  4 +-
> >  drivers/staging/octeon/ethernet-rx.c     |  6 +--
> >  drivers/staging/octeon/ethernet-tx.c     |  4 +-
> >  drivers/staging/octeon/ethernet.c        |  6 +--
> >  drivers/staging/octeon/octeon-ethernet.h |  2 +-
> >  drivers/staging/octeon/octeon-stubs.h    | 56 ++++++++++++------------
> >  7 files changed, 43 insertions(+), 41 deletions(-)
> 
> For the series:
> 
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>

This series breaks the build on MIPS/OCTEON (the only actual HW using this
driver):

$ make ARCH=mips CROSS_COMPILE=mips64-linux-gnu- cavium_octeon_defconfig
$ make ARCH=mips CROSS_COMPILE=mips64-linux-gnu-
[...]
  CC      drivers/staging/octeon/ethernet.o
In file included from drivers/staging/octeon/ethernet.c:22:
drivers/staging/octeon/octeon-ethernet.h:94:12: warning: 'union cvmx_helper_link_info' declared inside parameter list will not be visible outside of this definition or declaration
      union cvmx_helper_link_info li);  
            ^~~~~~~~~~~~~~~~~~~~~
drivers/staging/octeon/ethernet.c: In function 'cvm_oct_free_work':
drivers/staging/octeon/ethernet.c:177:21: error: dereferencing pointer to incomplete type 'struct cvmx_wqe'
  int segments = work->word2.s.bufs;
                     ^~
drivers/staging/octeon/ethernet.c: In function 'cvm_oct_common_open':
drivers/staging/octeon/ethernet.c:463:30: error: storage size of 'link_info' isn't known
  union cvmx_helper_link_info link_info;
                              ^~~~~~~~~

etc.

Probably all these patches need to be reverted.

A.
