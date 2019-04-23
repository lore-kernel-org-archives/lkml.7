Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BD0C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CDC217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jNRL/8y3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfDWT6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:58:19 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:44358 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWT6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:58:19 -0400
Received: by mail-vk1-f196.google.com with SMTP id q189so3483018vkq.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SFRe1EaYGLxy2UbJn8BRm0l3JurAoEbq7VB/O1a0Ucg=;
        b=jNRL/8y3RSPmxqdBfZCt41BTsk4p7/cm9sWVUdwq91bQlYiI2a4mTf3JD9HEilNHb6
         5t6uLBdaSoNYcdaACXQ2BLcmiOOPfH4CaiHPdzlNMpCmgLNCIouqGRwa4CVOeswYkgad
         Qh+CCYszX5TNp3PKd5jgQu/v8IEK3hMtumZv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SFRe1EaYGLxy2UbJn8BRm0l3JurAoEbq7VB/O1a0Ucg=;
        b=DehIx5pAcdg9KJFj59qfyejDiIoTqhptM4vrlac2iQhWL4mVG8bp0F1L2pK01tGD25
         5/xZ4REGBsQYEEeu+8HAx0zO/rS7Q1xUlHjZiwbI5JR4RWUaiximVqc+SaHND3Hb59Sy
         2KsadmxVp7vkZRc0CGF1TtK9nDyKrBfT3YzMtNf6FTBZH/+lyI0HOCgXl5nd9WqWgZIj
         YLDMgzmvxqeZUP5Zu0wEVoxK8ulp4B7zKANOJl1OXLLswh5s0evkFFbcLQXeVjJx3FaY
         sCvcFzzFoXwVxXXmzBh8oc06twZEwvD1AtMZtcV+nusiZeEv2075Ms5r5OHpdcAMe1aj
         VB2Q==
X-Gm-Message-State: APjAAAXIKMaVEdI9yCjXY8eKXNijcRT1PJk17Y7iDxqrQ6cDxEXSwjMI
        oycUq1RXLsr3lx+JyVSWSTq6OF8CpWk=
X-Google-Smtp-Source: APXvYqx/b1mG90RksAcv3+xIhOQ9DnBcJK6XjtWqD/4tVvIQEm3pM32qpXekx3kaAL33UiuOr3j+CA==
X-Received: by 2002:a1f:b712:: with SMTP id h18mr14381069vkf.62.1556049497412;
        Tue, 23 Apr 2019 12:58:17 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id q203sm5059748vkq.43.2019.04.23.12.58.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 12:58:16 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id b8so5212666uaq.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 12:58:16 -0700 (PDT)
X-Received: by 2002:ab0:791:: with SMTP id c17mr3887718uaf.96.1556049495849;
 Tue, 23 Apr 2019 12:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190409153622.28112-1-yuehaibing@huawei.com> <15b549db-827f-6d69-8098-144363363039@huawei.com>
In-Reply-To: <15b549db-827f-6d69-8098-144363363039@huawei.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 12:58:03 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJRaCvhjbLrVSP+-uoJ7qz11VdMd3Ty_mr3TeAV7jTFQQ@mail.gmail.com>
Message-ID: <CAGXu5jJRaCvhjbLrVSP+-uoJ7qz11VdMd3Ty_mr3TeAV7jTFQQ@mail.gmail.com>
Subject: Re: [PATCH] fs/proc/proc_sysctl.c: Fix a NULL pointer dereference
To:     YueHaibing <yuehaibing@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 7:54 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Friendly ping...
>
> On 2019/4/9 23:36, Yue Haibing wrote:
> > From: YueHaibing <yuehaibing@huawei.com>
> >
> > Syzkaller report this:
> >
> > sysctl could not get directory: /net//bridge -12
> > kasan: CONFIG_KASAN_INLINE enabled
> > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > general protection fault: 0000 [#1] SMP KASAN PTI
> > CPU: 1 PID: 7027 Comm: syz-executor.0 Tainted: G         C        5.1.0=
-rc3+ #8
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubu=
ntu1 04/01/2014
> > RIP: 0010:__write_once_size include/linux/compiler.h:220 [inline]
> > RIP: 0010:__rb_change_child include/linux/rbtree_augmented.h:144 [inlin=
e]
> > RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:186 [in=
line]
> > RIP: 0010:rb_erase+0x5f4/0x19f0 lib/rbtree.c:459
> > Code: 00 0f 85 60 13 00 00 48 89 1a 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e=
 41 5f c3 48 89 f2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 =
0f 85 75 0c 00 00 4d 85 ed 4c 89 2e 74 ce 4c 89 ea 48
> > RSP: 0018:ffff8881bb507778 EFLAGS: 00010206
> > RAX: dffffc0000000000 RBX: ffff8881f224b5b8 RCX: ffffffff818f3f6a
> > RDX: 000000000000000a RSI: 0000000000000050 RDI: ffff8881f224b568
> > RBP: 0000000000000000 R08: ffffed10376a0ef4 R09: ffffed10376a0ef4
> > R10: 0000000000000001 R11: ffffed10376a0ef4 R12: ffff8881f224b558
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > FS:  00007f3e7ce13700(0000) GS:ffff8881f7300000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fd60fbe9398 CR3: 00000001cb55c001 CR4: 00000000007606e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > PKRU: 55555554
> > Call Trace:
> >  erase_entry fs/proc/proc_sysctl.c:178 [inline]
> >  erase_header+0xe3/0x160 fs/proc/proc_sysctl.c:207
> >  start_unregistering fs/proc/proc_sysctl.c:331 [inline]
> >  drop_sysctl_table+0x558/0x880 fs/proc/proc_sysctl.c:1631
> >  get_subdir fs/proc/proc_sysctl.c:1022 [inline]
> >  __register_sysctl_table+0xd65/0x1090 fs/proc/proc_sysctl.c:1335
> >  ? 0xffffffffc1a88000
> >  br_netfilter_init+0x68/0x1000 [br_netfilter]
> >  do_one_initcall+0xbc/0x47d init/main.c:901
> >  do_init_module+0x1b5/0x547 kernel/module.c:3456
> >  load_module+0x6405/0x8c10 kernel/module.c:3804
> >  __do_sys_finit_module+0x162/0x190 kernel/module.c:3898
> >  do_syscall_64+0x9f/0x450 arch/x86/entry/common.c:290
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x462e99
> > Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f3e7ce12c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> > RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000462e99
> > RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000003
> > RBP: 00007f3e7ce12c70 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3e7ce136bc
> > R13: 00000000004bcefa R14: 00000000006f6fb0 R15: 0000000000000004
> > Modules linked in: br_netfilter(+) backlight comedi(C) hid_sensor_hub m=
ax3100 ti_ads8688 udc_core fddi snd_mona leds_gpio rc_streamzap mtd pata_ne=
tcell nf_log_common rc_winfast udp_tunnel snd_usbmidi_lib snd_usb_toneport =
snd_usb_line6 snd_rawmidi snd_seq_device snd_hwdep videobuf2_v4l2 videobuf2=
_common videodev media videobuf2_vmalloc videobuf2_memops rc_gadmei_rm008z =
8250_of smm665 hid_tmff hid_saitek hwmon_vid rc_ati_tv_wonder_hd_600 rc_cor=
e pata_pdc202xx_old dn_rtmsg as3722 ad714x_i2c ad714x snd_soc_cs4265 hid_ke=
nsington panel_ilitek_ili9322 drm drm_panel_orientation_quirks ipack cdc_ph=
onet usbcore phonet hid_jabra hid extcon_arizona can_dev industrialio_trigg=
ered_buffer kfifo_buf industrialio adm1031 i2c_mux_ltc4306 i2c_mux ipmi_msg=
handler mlxsw_core snd_soc_cs35l34 snd_soc_core snd_pcm_dmaengine snd_pcm s=
nd_timer ac97_bus snd_compress snd soundcore gpio_da9055 uio ecdh_generic m=
dio_thunder of_mdio fixed_phy libphy mdio_cavium iptable_security iptable_r=
aw iptable_mangle
> >  iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_=
filter bpfilter ip6_vti ip_vti ip_gre ipip sit tunnel4 ip_tunnel hsr veth n=
etdevsim vxcan batman_adv cfg80211 rfkill chnl_net caif nlmon dummy team bo=
nding vcan bridge stp llc ip6_gre gre ip6_tunnel tunnel6 tun joydev mousede=
v ppdev tpm kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_in=
tel ghash_clmulni_intel aesni_intel ide_pci_generic piix aes_x86_64 crypto_=
simd cryptd ide_core glue_helper input_leds psmouse intel_agp intel_gtt ser=
io_raw ata_generic i2c_piix4 agpgart pata_acpi parport_pc parport floppy rt=
c_cmos sch_fq_codel ip_tables x_tables sha1_ssse3 sha1_generic ipv6 [last u=
nloaded: br_netfilter]
> > Dumping ftrace buffer:
> >    (ftrace buffer empty)
> > ---[ end trace 68741688d5fbfe85 ]---
> >
> > commit 23da9588037e forget handle start_unregistering() case,
> > while header->parent is NULL, it calls erase_header
> > as above syzkaller call Trace, accessing &header->parent->root
> > will tigger another NULL pointer dereference.
> > As commit 23da9588037e explained, there also no need call
> > start_unregistering() if header->parent is NULL.
> >
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Fixes: 23da9588037e ("fs/proc/proc_sysctl.c: fix NULL pointer dereferen=
ce in put_links")
> > Fixes: 0e47c99d7fe25 ("sysctl: Replace root_list with links between sys=
ctl_table_sets")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>

This seems fine to me. Andrew, can you take this?

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

> > ---
> >  fs/proc/proc_sysctl.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > index d653907..7325baa 100644
> > --- a/fs/proc/proc_sysctl.c
> > +++ b/fs/proc/proc_sysctl.c
> > @@ -1626,9 +1626,11 @@ static void drop_sysctl_table(struct ctl_table_h=
eader *header)
> >       if (--header->nreg)
> >               return;
> >
> > -     if (parent)
> > +     if (parent) {
> >               put_links(header);
> > -     start_unregistering(header);
> > +             start_unregistering(header);
> > +     }
> > +
> >       if (!--header->count)
> >               kfree_rcu(header, rcu);
> >
> >
>


--=20
Kees Cook
