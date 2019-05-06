Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0889C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7482B20675
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfEFSFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 14:05:25 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.228]:27726 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726883AbfEFSFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 14:05:24 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 8408C16D7C
        for <linux-kernel@vger.kernel.org>; Mon,  6 May 2019 13:05:23 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id NhzOhbqWC2PzONhzOh4J8A; Mon, 06 May 2019 13:05:22 -0500
X-Authority-Reason: nr=8
Received: from [189.250.110.31] (port=35824 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hNhzN-000Shq-W9; Mon, 06 May 2019 13:05:22 -0500
Date:   Mon, 6 May 2019 13:05:21 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [GIT PULL] Wimplicit-fallthrough patches for 5.2-rc1
Message-ID: <20190506180521.GA30749@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.110.31
X-Source-L: No
X-Exim-ID: 1hNhzN-000Shq-W9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.110.31]:35824
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 17403fa277eda1328a7026dfca7e40249f27dc6b:

  Merge tag 'ext4_for_linus_stable' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4 (2019-03-24 13:41:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-5.2-rc1

for you to fetch changes up to ccaa75187a5f1d8131b424160eb90a8a94be287f:

  memstick: mark expected switch fall-throughs (2019-04-23 10:29:58 -0500)

----------------------------------------------------------------
Wimplicit-fallthrough patches for 5.2-rc1

Hi Linus,

This is my very first pull-request.  I've been working full-time as
a kernel developer for more than two years now. During this time I've
been fixing bugs reported by Coverity all over the tree and, as part
of my work, I'm also contributing to the KSPP. My work in the kernel
community has been supervised by Greg KH and Kees Cook.

OK. So, after the quick introduction above, please, pull the following
patches that mark switch cases where we are expecting to fall through.
These patches are part of the ongoing efforts to enable -Wimplicit-fallthrough.
They have been ignored for a long time (most of them more than 3 months,
even after pinging multiple times), which is the reason why I've created
this tree. Most of them have been baking in linux-next for a whole development
cycle. And with Stephen Rothwell's help, we've had linux-next nag-emails
going out for newly introduced code that triggers -Wimplicit-fallthrough
to avoid gaining more of these cases while we work to remove the ones
that are already present.

I'm happy to let you know that we are getting close to completing this
work.  Currently, there are only 32 of 2311 of these cases left to be
addressed in linux-next.  I'm auditing every case; I take a look into
the code and analyze it in order to determine if I'm dealing with an
actual bug or a false positive, as explained here:

https://lore.kernel.org/lkml/c2fad584-1705-a5f2-d63c-824e9b96cf50@embeddedor.com/

While working on this, I've found and fixed the following missing
break/return bugs, some of them introduced more than 5 years ago:

84242b82d81c54e009a2aaa74d3d9eff70babf56
7850b51b6c21812be96d0200b74cff1f40587d98
5e420fe635813e5746b296cfc8fff4853ae205a2
09186e503486da4a17f16f2f7c679e6e3e2a32f4
b5be853181a8d4a6e20f2073ccd273d6280cad88
7264235ee74f51d26fbdf97bf98c6102a460484f
cc5034a5d293dd620484d1d836aa16c6764a1c8c
479826cc86118e0d87e5cefb3df5b748e0480924
5340f23df8fe27a270af3fa1a93cd07293d23dd9
df997abeebadaa4824271009e2d2b526a70a11cb
2f10d823739680d2477ce34437e8a08a53117f40
307b00c5e695857ca92fc6a4b8ab6c48f988a1b1
5d25ff7a544889bc4b749fda31778d6a18dddbcb
a7ed5b3e7dca197de4da6273940a7ca6d1d756a1
c24bfa8f21b59283580043dada19a6e943b6e426
ad0eaee6195db1db1749dd46b9e6f4466793d178
9ba8376ce1e2cbf4ce44f7e4bee1d0648e10d594
dc586a60a11d0260308db1bebe788ad8973e2729
a8e9b186f153a44690ad0363a56716e7077ad28c
4e57562b4846e42cd1c2e556f0ece18c1154e116
60747828eac28836b49bed214399b0c972f19df3
c5b974bee9d2ceae4c441ae5a01e498c2674e100
cc44ba91166beb78f9cb29d5e3d41c0a2d0a7329
2c930e3d0aed1505e86e0928d323df5027817740

Once this work is finish, we'll be able to universally enable
"-Wimplicit-fallthrough" to avoid any of these kinds of bugs from
entering the kernel again.

Thanks

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

----------------------------------------------------------------
Gustavo A. R. Silva (27):
      fs: mark expected switch fall-throughs
      afs: Mark expected switch fall-throughs
      adfs: mark expected switch fall-throughs
      scsi: aic7xxx: mark expected switch fall-throughs
      scsi: be2iscsi: be_iscsi: Mark expected switch fall-through
      scsi: be2iscsi: be_main: Mark expected switch fall-through
      scsi: bfa: bfa_fcpim: Mark expected switch fall-throughs
      scsi: csiostor: csio_wr: mark expected switch fall-through
      scsi: imm: mark expected switch fall-throughs
      scsi: lpfc: lpfc_ct: Mark expected switch fall-throughs
      scsi: lpfc: lpfc_els: Mark expected switch fall-throughs
      scsi: lpfc: lpfc_hbadisc: Mark expected switch fall-throughs
      scsi: lpfc: lpfc_nportdisc: Mark expected switch fall-through
      scsi: lpfc: lpfc_nvme: Mark expected switch fall-through
      scsi: lpfc: lpfc_scsi: Mark expected switch fall-throughs
      scsi: osst: mark expected switch fall-throughs
      scsi: ppa: mark expected switch fall-through
      scsi: sym53c8xx_2: sym_hipd: mark expected switch fall-throughs
      scsi: sym53c8xx_2: sym_nvram: Mark expected switch fall-through
      lib: zstd: Mark expected switch fall-throughs
      lib/cmdline.c: mark expected switch fall-throughs
      ASN.1: mark expected switch fall-through
      block: Mark expected switch fall-throughs
      NFC: pn533: mark expected switch fall-throughs
      NFC: st21nfca: Fix fall-through warnings
      drm/nouveau/nvkm: mark expected switch fall-throughs
      memstick: mark expected switch fall-throughs

 drivers/block/drbd/drbd_int.h                      |  2 +-
 drivers/block/drbd/drbd_receiver.c                 |  4 +--
 drivers/block/drbd/drbd_req.c                      |  2 +-
 drivers/block/rsxx/core.c                          |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/hdmi.c    | 17 +++++++++++
 drivers/gpu/drm/nouveau/nvkm/engine/dma/usernv04.c |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c    |  2 ++
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv40.c    |  1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/perf.c    |  1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/pll.c     |  1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c     |  1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c    |  1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv40.c   |  2 ++
 drivers/gpu/drm/nouveau/nvkm/subdev/mxm/nv50.c     |  1 +
 drivers/memstick/host/jmb38x_ms.c                  |  2 ++
 drivers/memstick/host/tifm_ms.c                    |  2 ++
 drivers/nfc/pn533/pn533.c                          |  2 ++
 drivers/nfc/st21nfca/dep.c                         |  2 ++
 drivers/scsi/aic7xxx/aic7xxx_core.c                | 12 ++++++--
 drivers/scsi/be2iscsi/be_iscsi.c                   |  1 +
 drivers/scsi/be2iscsi/be_main.c                    |  1 +
 drivers/scsi/bfa/bfa_fcpim.c                       |  6 ++--
 drivers/scsi/csiostor/csio_wr.c                    |  1 +
 drivers/scsi/imm.c                                 | 33 +++++++++++-----------
 drivers/scsi/lpfc/lpfc_ct.c                        |  2 ++
 drivers/scsi/lpfc/lpfc_els.c                       |  1 +
 drivers/scsi/lpfc/lpfc_hbadisc.c                   |  4 ++-
 drivers/scsi/lpfc/lpfc_nportdisc.c                 |  1 +
 drivers/scsi/lpfc/lpfc_nvme.c                      |  1 +
 drivers/scsi/lpfc/lpfc_scsi.c                      |  8 +++---
 drivers/scsi/osst.c                                |  6 ++++
 drivers/scsi/ppa.c                                 |  1 +
 drivers/scsi/sym53c8xx_2/sym_hipd.c                |  2 ++
 drivers/scsi/sym53c8xx_2/sym_nvram.c               |  1 +
 fs/adfs/dir_f.c                                    |  6 ++++
 fs/affs/super.c                                    |  3 +-
 fs/afs/cmservice.c                                 |  8 ++++++
 fs/afs/file.c                                      |  2 ++
 fs/afs/flock.c                                     |  1 +
 fs/afs/fsclient.c                                  | 31 ++++++++++++--------
 fs/afs/misc.c                                      |  9 ++++++
 fs/afs/rxrpc.c                                     |  1 +
 fs/afs/vlclient.c                                  | 18 +++++++-----
 fs/afs/yfsclient.c                                 | 30 +++++++++++++-------
 fs/btrfs/ref-verify.c                              |  1 +
 fs/btrfs/volumes.h                                 |  1 +
 fs/ceph/file.c                                     |  1 +
 fs/configfs/dir.c                                  |  2 ++
 fs/f2fs/node.c                                     |  2 ++
 fs/fcntl.c                                         |  2 +-
 fs/gfs2/bmap.c                                     |  4 +--
 fs/jffs2/fs.c                                      |  1 +
 fs/libfs.c                                         |  2 ++
 fs/locks.c                                         |  2 +-
 fs/nfsd/nfs4proc.c                                 |  1 +
 fs/nfsd/nfs4state.c                                |  1 +
 fs/ocfs2/cluster/quorum.c                          |  1 +
 fs/seq_file.c                                      |  1 +
 fs/signalfd.c                                      |  1 +
 fs/ufs/util.h                                      |  4 +--
 lib/asn1_decoder.c                                 |  4 +++
 lib/cmdline.c                                      |  5 ++++
 lib/zstd/bitstream.h                               |  5 ++++
 lib/zstd/compress.c                                |  1 +
 lib/zstd/decompress.c                              |  5 +++-
 lib/zstd/huf_compress.c                            |  2 ++
 66 files changed, 216 insertions(+), 68 deletions(-)
