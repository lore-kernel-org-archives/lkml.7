Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7747DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 01:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52018206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 01:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfKKBuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 20:50:51 -0500
Received: from smtprelay0007.hostedemail.com ([216.40.44.7]:51003 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726743AbfKKBuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 20:50:50 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 68D4D181D341A;
        Mon, 11 Nov 2019 01:50:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: corn13_7079ff6b2031
X-Filterd-Recvd-Size: 4714
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Mon, 11 Nov 2019 01:50:48 +0000 (UTC)
Message-ID: <56f05dfb50dfc506a9cab539e522e8f80c738a4b.camel@perches.com>
Subject: Re: [GIT pull] core/urgent for v5.4-rc7
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Date:   Sun, 10 Nov 2019 17:50:32 -0800
In-Reply-To: <CAHk-=wiwhMFo6GFUAg3CZJMix4TJo59NBaSDciQxW23RHR8Zbg@mail.gmail.com>
References: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
         <698b03300532f80dfbd30fa35446a33e58ae0c89.camel@perches.com>
         <CAHk-=wiwhMFo6GFUAg3CZJMix4TJo59NBaSDciQxW23RHR8Zbg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-11-10 at 14:35 -0800, Linus Torvalds wrote:
> On Sun, Nov 10, 2019 at 2:01 PM Joe Perches <joe@perches.com> wrote:
> > trivia:
> > 
> > This idiom '!!(logical test)' is odd and redundant.
> > Logical test result is already 0 or 1, no !! is unnecessary.
> 
> You are of course correct.
> 
> I have to say, I personally have always disliked the idiomatic C "!!"
> pattern. I don't think it reads well, although that's probably "C
> cultural" - once you are used to the pattern, you don't think of it as
> anything else.
> 
> Personally, I prefer "x != 0" over "!!x" since it reads much better to
> a human, and is equally legible whether you're used to the !! pattern
> or not.
> 
> C is not perl, the Obfuscated C contest not-withstanding.
> 
> And since modern C has bool, if you really want to use a cast-to-bool
> instead of "x != 0", I think doing exactly that is preferable to "!!".
> 
> So I think both "x != 0" and "(bool)x" are preferable to "!!x", and
> would also have made it obvious how odd and redundant the test was in
> this case.
> 
> But "!!x" is shorter, of course. And it you learnt C with that pattern
> it looks obvious.

The !! logical usage is not particularly common in the kernel.
There seems to be only a couple/few dozen.

$ git grep -P '\!\!\s*\([^\)]+[\!=]=.*\);'
drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c:     info->realtek_eDPToLVDS = !!(lvds->dplvdsrxid == eDP_TO_LVDS_REALTEK_ID);
drivers/iio/resolver/ad2s1200.c:                gpiod_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
drivers/infiniband/hw/mlx5/mr.c:        MLX5_SET(mkc, mkc, en_rinval, !!((type == IB_MW_TYPE_2)));
drivers/leds/leds-max77693.c:   *state = !!(*state && (led->strobing_sub_led_id == sub_led->fled_id));
drivers/net/ethernet/qlogic/qed/qed_dcbx.c:     return !!(mfw_val == DCBX_APP_SF_IEEE_ETHTYPE);
drivers/net/ethernet/qlogic/qed/qed_dcbx.c:     return !!(mfw_val == type || mfw_val == DCBX_APP_SF_IEEE_TCP_UDP_PORT);
drivers/net/ethernet/qlogic/qed/qed_dcbx.c:     return !!(ethtype && (proto_id == QED_ETH_TYPE_DEFAULT));
drivers/net/ethernet/qlogic/qed/qed_dcbx.c:     return !!(port && (proto_id == QED_TCP_PORT_ISCSI));
drivers/net/ethernet/qlogic/qed/qed_dcbx.c:     return !!(ethtype && (proto_id == QED_ETH_TYPE_FCOE));
drivers/net/ethernet/qlogic/qed/qed_dcbx.c:     return !!(ethtype && (proto_id == QED_ETH_TYPE_ROCE));
drivers/net/ethernet/qlogic/qed/qed_dcbx.c:     return !!(port && (proto_id == QED_UDP_PORT_TYPE_ROCE_V2));
drivers/net/ethernet/qlogic/qed/qed_dcbx.c:     ethtype = !!(idtype == DCB_APP_IDTYPE_ETHTYPE);
drivers/net/ethernet/qlogic/qed/qed_dcbx.c:     ethtype = !!(idtype == DCB_APP_IDTYPE_ETHTYPE);
drivers/net/wireless/ath/ath9k/recv.c:  is_40 = !!(rxs->bw == RATE_INFO_BW_40);
drivers/pci/controller/pcie-iproc.c:    return !!(reg_offset == IPROC_PCIE_REG_INVALID);
drivers/pci/controller/pcie-iproc.c:    return !!(ib_map->type == type);
drivers/pci/hotplug/pnv_php.c:          added = !!(presence == OPAL_PCI_SLOT_PRESENT);
drivers/platform/x86/asus-wmi.c:                ctrl_param = !!(bd->props.power == FB_BLANK_UNBLANK);
drivers/scsi/hisi_sas/hisi_sas_main.c:          bool do_port_check = !!(_sas_port != sas_port);
fs/ocfs2/reservations.c:        return !!(resv->r_len == 0);
fs/ubifs/journal.c:     int last_reference = !!(deletion && inode->i_nlink == 0);
fs/ubifs/journal.c:     int last_reference = !!(new_inode && new_inode->i_nlink == 0);
sound/firewire/amdtp-stream.c:          !!(params->header_length == 0 && params->payload_length == 0);
tools/perf/util/time-utils.c:           num += !!(*cp == ',');



