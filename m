Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6149DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C3520854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552516551;
	bh=/5GMVkBGtglsbRhLAKMLvIxfn1XPuyFGc/L7PIXgXyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T4X/Z9nwtow7u1Ya1h+c1IBiP9fUP+yTqhdL+dW1B/nW/4dI3QkwttN3/HuaOpbb8
	 YtSsNyyVYjYF7x5EuWPu5BhnxtqorRB8y2mom7YbCx1Lx5Me+G3Sz/V1efQ+H49A/7
	 AF5uLkl82e9s6geQNn9OXxpYSlxglPoD8k06jV6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfCMWft convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:35:49 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41720 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfCMWfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 18:35:48 -0400
Received: by mail-yw1-f68.google.com with SMTP id q128so2843779ywg.8;
        Wed, 13 Mar 2019 15:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9WeF9RZ8khVD+iyMX4ZOmeuicJz1YEso0EQWKYDNg3k=;
        b=V2bxp75sC4f1Mb491FB6CoMFyCYiDgVNKYwINWvYu6aAmulzEIHAm1bt4Uth/sas6d
         OG92raz90uKfPi8thaZbgmW818FpGZhghnJpaicl41Z4xnEoYx8BHq+vRs9XomKRkbP8
         Qtdc2hixcA5N8NsooJ28LJv+DMGXaLWZ36kPp1nskImCrr8gIkzfEOo4TcOdzaG1WLiy
         648rHAhvm7dkmDgOJDIMMpik10Od7MCfsFS4CP5mLSodjiI9z/VWeOgWRo+gHLvjMGJr
         R2VuT3f7xwbmg6WFt2cR0lyAlfy1iV+WI9NPNuV47khxK9VPw2B0GsamZSGm//s9j63w
         tbOQ==
X-Gm-Message-State: APjAAAUDxCOnDIVEkyOkBegbPoTTI7nUS43njwYwvVvpqihLgvKLAJq+
        2J3/IZqgr4MLnxXHKRZVdc0=
X-Google-Smtp-Source: APXvYqwy1k7INOcEa1Q1gh7PBfWC/bSopduHM6QQOshy48dTellAbZaQaJzKJ3fiENvRoboC+e2pKg==
X-Received: by 2002:a81:ae61:: with SMTP id g33mr37566777ywk.220.1552516547035;
        Wed, 13 Mar 2019 15:35:47 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id n128sm4213553ywf.74.2019.03.13.15.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 15:35:45 -0700 (PDT)
Received: by 42.do-not-panic.com (sSMTP sendmail emulation); Wed, 13 Mar 2019 22:35:43 +0000
Date:   Wed, 13 Mar 2019 22:35:43 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] proc/sysctl: Fix NULL pointer dereference in put_links
Message-ID: <20190313223543.GA993@42.do-not-panic.com>
References: <20190304135438.29792-1-yuehaibing@huawei.com>
 <03aafd33-f9d5-4a48-b123-7a6b2e7f16e7@huawei.com>
 <CAB=NE6UF=2pWzOFY2PqpXyuDV3qSa7R8bpMAw-6qF9Z7Ly=PEw@mail.gmail.com>
 <43f6b8c5-a9eb-c77d-0c52-dbc3c45b4dc7@huawei.com>
 <e5d45b4e-b821-f993-7e88-6b0c35159d5e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <e5d45b4e-b821-f993-7e88-6b0c35159d5e@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 10:10:53AM +0800, YueHaibing wrote:
> On 2019/3/9 20:27, YueHaibing wrote:
> > On 2019/3/9 11:58, Luis Chamberlain wrote:
> >> I so excited about the report, thanks this is awesome work!! However it seemed possibly like a paper-over a different issue. I'm not convinced yet.
> >>
> >> If prefer a bit more investigation until we can be 100% sure. At
> >> this point my position would be this is more of a risk for more
> >> regressions and that's an off feeling for a fix.
> >>
> >>   Luis
> > 
> > This issue occurs like this:
> > 
> > __register_sysctl_table
> >      -->get_subdir
> >      	-->new_dir  //create 'new' dir
> >             -->init_header  // &new->header->parent = NULL
> >         -->insert_header
> >             --> insert_links
> > 		-->new_links
> > 			-->kzalloc  //failed
> > 		-->&new->header->parent = NULL
> > 	-->drop_sysctl_table(&new->header) //In err path of get_subdir

Nope, we drop  that earlier actually, note that upon failure on
insert_links() we also call drop_sysctl_table(). And even in
the successful case on __register_sysctl_table() we still always
call drop_sysctl_table().

So it seems that the real issue is we have multiple error paths which
call drop_sysctl_table().  That is the justification for which we do
need your patch. Can you adjust your commit log to account for this?

  Luis

> > 		-->put_links //call xlate_dir whose 2nd param is '&new->header->parent'
> > 			--> xlate_dir  //access dir->header,however 'dir' is NULL which comes from '&new->header->parent'
> > 
> > Please correct me if this is incorrect.
> 
> Hello,
> 
> Any comment will be appreciated.
> 
> > 	
> >>
> >> On Fri, Mar 8, 2019, 8:04 PM YueHaibing <yuehaibing@huawei.com <mailto:yuehaibing@huawei.com>> wrote:
> >>
> >>     +cc Al Viro
> >>
> >>     On 2019/3/4 21:54, Yue Haibing wrote:
> >>     > From: YueHaibing <yuehaibing@huawei.com <mailto:yuehaibing@huawei.com>>
> >>     >
> >>     > Syzkaller report this:
> >>     >
> >>     > kasan: GPF could be caused by NULL-ptr deref or user memory access
> >>     > general protection fault: 0000 [#1] SMP KASAN PTI
> >>     > CPU: 1 PID: 5373 Comm: syz-executor.0 Not tainted 5.0.0-rc8+ #3
> >>     > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> >>     > RIP: 0010:put_links+0x101/0x440 fs/proc/proc_sysctl.c:1599
> >>     > Code: 00 0f 85 3a 03 00 00 48 8b 43 38 48 89 44 24 20 48 83 c0 38 48 89 c2 48 89 44 24 28 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 fe 02 00 00 48 8b 74 24 20 48 c7 c7 60 2a 9d 91
> >>     > RSP: 0018:ffff8881d828f238 EFLAGS: 00010202
> >>     > RAX: dffffc0000000000 RBX: ffff8881e01b1140 RCX: ffffffff8ee98267
> >>     > RDX: 0000000000000007 RSI: ffffc90001479000 RDI: ffff8881e01b1178
> >>     > RBP: dffffc0000000000 R08: ffffed103ee27259 R09: ffffed103ee27259
> >>     > R10: 0000000000000001 R11: ffffed103ee27258 R12: fffffffffffffff4
> >>     > R13: 0000000000000006 R14: ffff8881f59838c0 R15: dffffc0000000000
> >>     > FS:  00007f072254f700(0000) GS:ffff8881f7100000(0000) knlGS:0000000000000000
> >>     > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>     > CR2: 00007fff8b286668 CR3: 00000001f0542002 CR4: 00000000007606e0
> >>     > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>     > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>     > PKRU: 55555554
> >>     > Call Trace:
> >>     >  drop_sysctl_table+0x152/0x9f0 fs/proc/proc_sysctl.c:1629
> >>     >  get_subdir fs/proc/proc_sysctl.c:1022 [inline]
> >>     >  __register_sysctl_table+0xd65/0x1090 fs/proc/proc_sysctl.c:1335
> >>     >  ? 0xffffffffc1a18000
> >>     >  br_netfilter_init+0xbc/0x1000 [br_netfilter]
> >>     >  ? 0xffffffffc1a18000
> >>     >  ? 0xffffffffc1a18000
> >>     >  do_one_initcall+0xfa/0x5ca init/main.c:887
> >>     >  do_init_module+0x204/0x5f6 kernel/module.c:3460
> >>     >  load_module+0x66b2/0x8570 kernel/module.c:3808
> >>     >  __do_sys_finit_module+0x238/0x2a0 kernel/module.c:3902
> >>     >  do_syscall_64+0x147/0x600 arch/x86/entry/common.c:290
> >>     >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >>     > RIP: 0033:0x462e99
> >>     > Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> >>     > RSP: 002b:00007f072254ec58 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> >>     > RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000462e99
> >>     > RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000003
> >>     > RBP: 00007f072254ec70 R08: 0000000000000000 R09: 0000000000000000
> >>     > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f072254f6bc
> >>     > R13: 00000000004bcefa R14: 00000000006f6fb0 R15: 0000000000000004
> >>     > Modules linked in: br_netfilter(+) dvb_usb_dibusb_mc_common dib3000mc dibx000_common dvb_usb_dibusb_common dvb_usb_dw2102 dvb_usb classmate_laptop palmas_regulator cn videobuf2_v4l2 v4l2_common snd_soc_bd28623 mptbase snd_usb_usx2y snd_usbmidi_lib snd_rawmidi wmi libnvdimm lockd sunrpc grace rc_kworld_pc150u rc_core rtc_da9063 sha1_ssse3 i2c_cros_ec_tunnel adxl34x_spi adxl34x nfnetlink lib80211 i5500_temp dvb_as102 dvb_core videobuf2_common videodev media videobuf2_vmalloc videobuf2_memops udc_core lnbp22 leds_lp3952 hid_roccat_ryos s1d13xxxfb mtd vport_geneve openvswitch nf_conncount nf_nat_ipv6 nsh geneve udp_tunnel ip6_udp_tunnel snd_soc_mt6351 sis_agp phylink snd_soc_adau1761_spi snd_soc_adau1761 snd_soc_adau17x1 snd_soc_core snd_pcm_dmaengine ac97_bus snd_compress snd_soc_adau_utils snd_soc_sigmadsp_regmap snd_soc_sigmadsp raid_class hid_roccat_konepure hid_roccat_common hid_roccat c2port_duramar2150 core mdio_bcm_unimac iptable_security iptable_raw iptable_mangle
> >>     >  iptable_nat nf_nat_ipv4 nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter bpfilter ip6_vti ip_vti ip_gre ipip sit tunnel4 ip_tunnel hsr veth netdevsim devlink vxcan batman_adv cfg80211 rfkill chnl_net caif nlmon dummy team bonding vcan bridge stp llc ip6_gre gre ip6_tunnel tunnel6 tun crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel joydev mousedev ide_pci_generic piix aesni_intel aes_x86_64 ide_core crypto_simd atkbd cryptd glue_helper serio_raw ata_generic pata_acpi i2c_piix4 floppy sch_fq_codel ip_tables x_tables ipv6 [last unloaded: lm73]
> >>     > Dumping ftrace buffer:
> >>     >    (ftrace buffer empty)
> >>     > ---[ end trace 770020de38961fd0 ]---
> >>     >
> >>     > A new dir entry can be created in get_subdir and its header->parent is set
> >>     > to NULL. Only after insert_header success, it will be set to 'dir'.
> >>     > However in err handling path of get_subdir, drop_sysctl_table maybe called
> >>     > on 'new->header' regardless value of header->parent. Then put_links
> >>     > be called, which triggers NULL-ptr deref when access the member of
> >>     > header->parent in xlate_dir.
> >>     >
> >>     > Reported-by: Hulk Robot <hulkci@huawei.com <mailto:hulkci@huawei.com>>
> >>     > Fixes: 0e47c99d7fe25 ("sysctl: Replace root_list with links between sysctl_table_sets")
> >>     > Signed-off-by: YueHaibing <yuehaibing@huawei.com <mailto:yuehaibing@huawei.com>>
> >>     > ---
> >>     >  fs/proc/proc_sysctl.c | 3 ++-
> >>     >  1 file changed, 2 insertions(+), 1 deletion(-)
> >>     >
> >>     > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> >>     > index 4d598a3..4c2a05a 100644
> >>     > --- a/fs/proc/proc_sysctl.c
> >>     > +++ b/fs/proc/proc_sysctl.c
> >>     > @@ -1626,7 +1626,8 @@ static void drop_sysctl_table(struct ctl_table_header *header)
> >>     >       if (--header->nreg)
> >>     >               return;
> >>     > 
> >>     > -     put_links(header);
> >>     > +     if (parent)
> >>     > +             put_links(header);
> >>     >       start_unregistering(header);
> >>     >       if (!--header->count)
> >>     >               kfree_rcu(header, rcu);
> >>     >
> >>
