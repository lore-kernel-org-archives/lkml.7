Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA05BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672B820850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Vv8+NcK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbfCYLoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:44:10 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44323 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729831AbfCYLoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:44:09 -0400
Received: by mail-lf1-f67.google.com with SMTP id u9so5706143lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 04:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=STVtBEJFAy7guvMQznMMHoAPBqHK4M4Oqjl7fkbLEOE=;
        b=Vv8+NcK2tZUu7pQwfOEOsr3jdZJuSyG3qAZ0bpVe6H+41rx4Ll/D0lY1btMFObOnuP
         x1XqsDVwRFz6znuHO7YtAooB1avVatv9qDi1554tPpPydPFPdw95sOkhCIro/XYieRho
         rxOYd/tsivaQurugBgGbzkb1jQbLT7RVoDNr8HRoH/Qqho27FMed+uPiWE6h8APlPqXs
         GJN2miDq3X6vvqF6SjL8LNVUzo6c4tunermmtmg0AVyAZYsShqxBFyvyk7z0utQ48j+q
         kiiCv2g8RrHq4Et/p2M5wSevCdpPw95zhsb83a8OHbnhLWGQ6E5nFpEeFROtNhP/wUVN
         lbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=STVtBEJFAy7guvMQznMMHoAPBqHK4M4Oqjl7fkbLEOE=;
        b=E9aZlVM1MvaMrKGLPMfICY1n0iEIiOjuIeZ/JYFHd508lPGzOvP9ftA1n1tnHxlxXh
         GRkUJ0FY7aEQFQp1bnTz5c2TcHU8ruJmBkKtjxvRp1jLzknEEVUqp0+B1aq1IeL47Y3q
         VAPGUZ9wWudeSFweERGJlQ6E42NL/sAnQ38wAdZBFNo1ST6a0hwapMnC1YGOkNCCFN1v
         Ik6BS8/6UQhZkDXCDqtg9XHlTfEmGMyzcBX3TCUTVWr/59C45Df4/OHgXezvZNHhqLv+
         2wph8rIrsyNNVFqV3GyCT8+PEk10u4TqbvPEK4ApfrRhpxW+mhvBj9fOjmMs2Y0HXWMW
         i5tA==
X-Gm-Message-State: APjAAAXIRnCqO78/m/iPXlKAee0MikpkdMRXt7W3u+O3ees0HZdylnAz
        8hWDiRc4L93Fyfq5lfHJsGPRximntdtOJxpVBAejpGuyzn0=
X-Google-Smtp-Source: APXvYqxM4pvLkUdXZcSgLpyqoCOP309gPiG5eEBvuHwZkTSKQhgMG+N9mYLTO1Vw6c67Huo5Zei13cXac0+xu0OPBY0=
X-Received: by 2002:a19:a908:: with SMTP id s8mr12063938lfe.160.1553514246332;
 Mon, 25 Mar 2019 04:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <1552378289-27245-1-git-send-email-yash.shah@sifive.com>
 <mvmimwotn60.fsf@suse.de> <CAJ2_jOE3RH9FyFg_NATcLEpHv5y89zdh06Ji2x8n3C_gp-wn6A@mail.gmail.com>
 <mvm5zsgp00d.fsf@suse.de> <CAJ2_jOHoNnBF2UwU6G1vdvNrJAUJdGL_RncRAOaXMWoS03cagA@mail.gmail.com>
In-Reply-To: <CAJ2_jOHoNnBF2UwU6G1vdvNrJAUJdGL_RncRAOaXMWoS03cagA@mail.gmail.com>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Mon, 25 Mar 2019 17:13:29 +0530
Message-ID: <CAJ2_jOFrXcxRS1oYOuYhtuRReTocmPKnoe5GO_3r_B1uAZb+xA@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] PWM support for HiFive Unleashed
To:     Andreas Schwab <schwab@suse.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Tue, Mar 19, 2019 at 11:56 AM Yash Shah <yash.shah@sifive.com> wrote:
>
> On Mon, Mar 18, 2019 at 10:56 PM Andreas Schwab <schwab@suse.de> wrote:
> >
> > On M=C3=A4r 15 2019, Yash Shah <yash.shah@sifive.com> wrote:
> >
> > > You need to make sure the period setting is passed via the
> > > conventional way in DT file.
> > > Example:
> > > pwmleds {
> > >     compatible =3D "pwm-leds";
> > >     heartbeat {
> > >         pwms =3D <&L45 0 10000000 0>;
> > >         max-brightness =3D <255>;
> > >         linux,default-trigger =3D "heartbeat";
> > >     };
> > > };
> >
> > I've now managed to build a working FSBL with that change, but that
> > didn't change anything.  There is not even a heartbeat option in
> > /sys/class/leds/heartbeat/trigger any more.
>
...
>
> The above works for me.
> I just noticed that I have been using pwm-cells =3D 2, instead of 3.
> Maybe that is the problem here.
> I will suggest you test it on v11 patch in which I will fix this
> pwm-cells issue.

I have sent out the v11 patchset, you can test the heartbeat
application with that patchset.
You still need to make that DT file modification which you previously
did, using fsbl.bin
Just for your reference, I am copying my DT file and kernel config
which I used for my test.
The same is available at dev/yashs/pwm_5.0-rc1 branch of
https://github.com/yashshah7/riscv-linux.git

/dts-v1/;

/*#include <linux/clk/sifive-fu540-prci.h>*/
#define PRCI_CLK_TLCLK 3

/ {
#address-cells =3D <2>;
#size-cells =3D <2>;
compatible =3D "sifive,fu540-c000";

aliases {
serial0 =3D &uart0;
serial1 =3D &uart1;
};

chosen {
};

cpus {
#address-cells =3D <1>;
#size-cells =3D <0>;
timebase-frequency =3D <1000000>;
cpu0: cpu@0 {
clock-frequency =3D <0>;
compatible =3D "sifive,u51", "sifive,rocket0", "riscv";
device_type =3D "cpu";
i-cache-block-size =3D <64>;
i-cache-sets =3D <128>;
i-cache-size =3D <16384>;
reg =3D <0>;
riscv,isa =3D "rv64imac";
status =3D "okay";
cpu0_intc: interrupt-controller {
#interrupt-cells =3D <1>;
compatible =3D "riscv,cpu-intc";
interrupt-controller;
};
};
cpu1: cpu@1 {
clock-frequency =3D <0>;
compatible =3D "sifive,u54-mc", "sifive,rocket0", "riscv";
d-cache-block-size =3D <64>;
d-cache-sets =3D <64>;
d-cache-size =3D <32768>;
d-tlb-sets =3D <1>;
d-tlb-size =3D <32>;
device_type =3D "cpu";
i-cache-block-size =3D <64>;
i-cache-sets =3D <64>;
i-cache-size =3D <32768>;
i-tlb-sets =3D <1>;
i-tlb-size =3D <32>;
mmu-type =3D "riscv,sv39";
reg =3D <1>;
riscv,isa =3D "rv64imafdc";
status =3D "okay";
tlb-split;
cpu1_intc: interrupt-controller {
#interrupt-cells =3D <1>;
compatible =3D "riscv,cpu-intc";
interrupt-controller;
};
};
cpu2: cpu@2 {
clock-frequency =3D <0>;
compatible =3D "sifive,u54-mc", "sifive,rocket0", "riscv";
d-cache-block-size =3D <64>;
d-cache-sets =3D <64>;
d-cache-size =3D <32768>;
d-tlb-sets =3D <1>;
d-tlb-size =3D <32>;
device_type =3D "cpu";
i-cache-block-size =3D <64>;
i-cache-sets =3D <64>;
i-cache-size =3D <32768>;
i-tlb-sets =3D <1>;
i-tlb-size =3D <32>;
mmu-type =3D "riscv,sv39";
reg =3D <2>;
riscv,isa =3D "rv64imafdc";
status =3D "okay";
tlb-split;
cpu2_intc: interrupt-controller {
#interrupt-cells =3D <1>;
compatible =3D "riscv,cpu-intc";
interrupt-controller;
};
};
cpu3: cpu@3 {
clock-frequency =3D <0>;
compatible =3D "sifive,u54-mc", "sifive,rocket0", "riscv";
d-cache-block-size =3D <64>;
d-cache-sets =3D <64>;
d-cache-size =3D <32768>;
d-tlb-sets =3D <1>;
d-tlb-size =3D <32>;
device_type =3D "cpu";
i-cache-block-size =3D <64>;
i-cache-sets =3D <64>;
i-cache-size =3D <32768>;
i-tlb-sets =3D <1>;
i-tlb-size =3D <32>;
mmu-type =3D "riscv,sv39";
reg =3D <3>;
riscv,isa =3D "rv64imafdc";
status =3D "okay";
tlb-split;
cpu3_intc: interrupt-controller {
#interrupt-cells =3D <1>;
compatible =3D "riscv,cpu-intc";
interrupt-controller;
};
};
cpu4: cpu@4 {
clock-frequency =3D <0>;
compatible =3D "sifive,u54-mc", "sifive,rocket0", "riscv";
d-cache-block-size =3D <64>;
d-cache-sets =3D <64>;
d-cache-size =3D <32768>;
d-tlb-sets =3D <1>;
d-tlb-size =3D <32>;
device_type =3D "cpu";
i-cache-block-size =3D <64>;
i-cache-sets =3D <64>;
i-cache-size =3D <32768>;
i-tlb-sets =3D <1>;
i-tlb-size =3D <32>;
mmu-type =3D "riscv,sv39";
reg =3D <4>;
riscv,isa =3D "rv64imafdc";
status =3D "okay";
tlb-split;
cpu4_intc: interrupt-controller {
#interrupt-cells =3D <1>;
compatible =3D "riscv,cpu-intc";
interrupt-controller;
};
};
};
soc {
#address-cells =3D <2>;
#size-cells =3D <2>;
compatible =3D "sifive,fu540-soc", "simple-bus";
ranges;
prci: prci@10000000 {
compatible =3D "sifive,fu540-c000-prci";
reg =3D <0x0 0x10000000 0x0 0x1000>;
clocks =3D <&hfclk>, <&rtcclk>;
#clock-cells =3D <1>;
};
uart0: serial@10010000 {
compatible =3D "sifive,fu540-c000-uart", "sifive,uart0";
interrupt-parent =3D <&plic0>;
interrupts =3D <4>;
reg =3D <0x0 0x10010000 0x0 0x1000>;
clocks =3D <&prci PRCI_CLK_TLCLK>;
};
uart1: serial@10011000 {
compatible =3D "sifive,fu540-c000-uart", "sifive,uart0";
interrupt-parent =3D <&plic0>;
interrupts =3D <5>;
reg =3D <0x0 0x10011000 0x0 0x1000>;
clocks =3D <&prci PRCI_CLK_TLCLK>;
};
L5: clint@2000000 {
compatible =3D "riscv,clint0";
interrupts-extended =3D <
&cpu0_intc 3 &cpu0_intc 7
&cpu1_intc 3 &cpu1_intc 7
&cpu2_intc 3 &cpu2_intc 7
&cpu3_intc 3 &cpu3_intc 7
&cpu4_intc 3 &cpu4_intc 7>;
reg =3D <0x0 0x2000000 0x0 0x10000>;
                };
plic0: interrupt-controller@c000000 {
#interrupt-cells =3D <1>;
compatible =3D "riscv,plic0";
interrupt-controller;
interrupts-extended =3D <
&cpu0_intc 11
&cpu1_intc 11 &cpu1_intc 9
&cpu2_intc 11 &cpu2_intc 9
&cpu3_intc 11 &cpu3_intc 9
&cpu4_intc 11 &cpu4_intc 9>;
reg =3D <0x0 0xc000000 0x0 0x4000000>;
                        riscv,ndev =3D <53>;
};
L45: pwm@10020000 {
                        compatible =3D "sifive,pwm0";
                        interrupt-parent =3D <&plic0>;
                        interrupts =3D <42 43 44 45>;
                        reg =3D <0x0 0x10020000 0x0 0x1000>;
                        reg-names =3D "control";
                        clocks =3D <&prci 3>;
                        #pwm-cells =3D <3>;
                };
                L46: pwm@10021000 {
                        compatible =3D "sifive,pwm0";
                        interrupt-parent =3D <&plic0>;
                        interrupts =3D <46 47 48 49>;
                        reg =3D <0x0 0x10021000 0x0 0x1000>;
                        reg-names =3D "control";
                        clocks =3D <&prci 3>;
                        #pwm-cells =3D <3>;
                };
pwmleds {
                        compatible =3D "pwm-leds";
                        heartbeat {
                                pwms =3D <&L45 0 100000 0>;
                                max-brightness =3D <255>;
                                linux,default-trigger =3D "heartbeat";
                        };
                        mtd {
                                pwms =3D <&L45 1 100000 0>;
                                max-brightness =3D <255>;
                                linux,default-trigger =3D "mtd";
                        };
                        netdev {
                                pwms =3D <&L45 2 100000 0>;
                                max-brightness =3D <255>;
                                linux,default-trigger =3D "netdev";
                        };
                        panic {
                                pwms =3D <&L45 3 100000 0>;
                                max-brightness =3D <255>;
                                linux,default-trigger =3D "panic";
                        };
};
};
};


kernel config:
CONFIG_SYSVIPC=3Dy
CONFIG_POSIX_MQUEUE=3Dy
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
CONFIG_CGROUPS=3Dy
CONFIG_CGROUP_SCHED=3Dy
CONFIG_CFS_BANDWIDTH=3Dy
CONFIG_CGROUP_BPF=3Dy
CONFIG_NAMESPACES=3Dy
CONFIG_USER_NS=3Dy
CONFIG_CHECKPOINT_RESTORE=3Dy
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_EXPERT=3Dy
CONFIG_BPF_SYSCALL=3Dy
CONFIG_SMP=3Dy
CONFIG_PCI=3Dy
CONFIG_PCIE_XILINX=3Dy
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_NET=3Dy
CONFIG_PACKET=3Dy
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
CONFIG_IP_PNP=3Dy
CONFIG_IP_PNP_DHCP=3Dy
CONFIG_IP_PNP_BOOTP=3Dy
CONFIG_IP_PNP_RARP=3Dy
CONFIG_NETLINK_DIAG=3Dy
CONFIG_DEVTMPFS=3Dy
CONFIG_BLK_DEV_LOOP=3Dy
CONFIG_VIRTIO_BLK=3Dy
CONFIG_BLK_DEV_SD=3Dy
CONFIG_BLK_DEV_SR=3Dy
CONFIG_ATA=3Dy
CONFIG_SATA_AHCI=3Dy
CONFIG_SATA_AHCI_PLATFORM=3Dy
CONFIG_NETDEVICES=3Dy
CONFIG_VIRTIO_NET=3Dy
CONFIG_MACB=3Dy
CONFIG_E1000E=3Dy
CONFIG_R8169=3Dy
CONFIG_MICROSEMI_PHY=3Dy
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
CONFIG_SERIAL_OF_PLATFORM=3Dy
CONFIG_SERIAL_EARLYCON_RISCV_SBI=3Dy
CONFIG_SERIAL_SIFIVE=3Dy
CONFIG_SERIAL_SIFIVE_CONSOLE=3Dy
CONFIG_HVC_RISCV_SBI=3Dy
# CONFIG_PTP_1588_CLOCK is not set
CONFIG_DRM=3Dy
CONFIG_DRM_RADEON=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
CONFIG_USB=3Dy
CONFIG_USB_XHCI_HCD=3Dy
CONFIG_USB_XHCI_PLATFORM=3Dy
CONFIG_USB_EHCI_HCD=3Dy
CONFIG_USB_EHCI_HCD_PLATFORM=3Dy
CONFIG_USB_OHCI_HCD=3Dy
CONFIG_USB_OHCI_HCD_PLATFORM=3Dy
CONFIG_USB_STORAGE=3Dy
CONFIG_USB_UAS=3Dy
CONFIG_VIRTIO_MMIO=3Dy
CONFIG_SIFIVE_PLIC=3Dy
CONFIG_RAS=3Dy
CONFIG_EXT4_FS=3Dy
CONFIG_EXT4_FS_POSIX_ACL=3Dy
CONFIG_AUTOFS4_FS=3Dy
CONFIG_MSDOS_FS=3Dy
CONFIG_VFAT_FS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_TMPFS_POSIX_ACL=3Dy
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V4=3Dy
CONFIG_NFS_V4_1=3Dy
CONFIG_NFS_V4_2=3Dy
CONFIG_ROOT_NFS=3Dy
CONFIG_CRYPTO_USER_API_HASH=3Dy
CONFIG_PRINTK_TIME=3Dy
# CONFIG_RCU_TRACE is not set
CONFIG_CMDLINE_BOOL=3Dy
CONFIG_CMDLINE=3D"console=3DttySIF0,115200 ignore_loglevel debug"
CONFIG_CLK_SIFIVE=3Dy
CONFIG_CLK_SIFIVE_FU540_PRCI=3Dy

- Yash
> >
> > Andreas.
> >
> > --
> > Andreas Schwab, SUSE Labs, schwab@suse.de
> > GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B=
9D7
> > "And now for something completely different."
