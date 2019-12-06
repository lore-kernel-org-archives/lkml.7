Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1F9C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F4B24659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfLFHpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 02:45:07 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:42586 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfLFHpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 02:45:07 -0500
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1id8IT-0007Hp-HS; Fri, 06 Dec 2019 07:45:05 +0000
Received: from sleer.kot-begemot.co.uk ([192.168.3.72])
        by jain.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1id8IR-0005uH-Cl; Fri, 06 Dec 2019 07:45:05 +0000
Subject: Re: [RFC v1 0/2] um: drop broken features to fix allyesconfig
To:     Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com,
        richard@nod.at
Cc:     davidgow@google.com, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, johannes.berg@intel.com
References: <20191206020153.228283-1-brendanhiggins@google.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <dd086a74-402c-5b9a-5a12-15a791f8749f@cambridgegreys.com>
Date:   Fri, 6 Dec 2019 07:45:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191206020153.228283-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2019 02:01, Brendan Higgins wrote:
> # TL;DR
> 
> This patchset drops two broken features in an attempt to get
> allyesconfig closer to working for ARCH=um.
> 
> # What am I trying to do?
> 
> This patchset is part of my attempt to get `make ARCH=um allyesconfig`
> to produce a config that will build *and* boot to init, so that I can
> use it as a mechanism to run tests[1].
> 
> # How far away are we from an allyesconfig UML kernel?
> 
> I have identified 33 Kconfigs that are selected by allyesconfig, but
> will either not build on UML, or prevent it from booting. They are:
> 
> CONFIG_STATIC_LINK=y
> CONFIG_UML_NET_PCAP=y
> CONFIG_NET_PTP_CLASSIFY=y
> CONFIG_IP_VS=y
> CONFIG_BRIDGE_EBT_BROUTE=y
> CONFIG_BRIDGE_EBT_T_FILTER=y
> CONFIG_BRIDGE_EBT_T_NAT=y
> CONFIG_MTD_NAND_CADENCE=y
> CONFIG_MTD_NAND_NANDSIM=y
> CONFIG_BLK_DEV_NULL_BLK=y
> CONFIG_BLK_DEV_RAM=y
> CONFIG_SCSI_DEBUG=y
> CONFIG_NET_VENDOR_XILINX=y
> CONFIG_NULL_TTY=y
> CONFIG_PTP_1588_CLOCK=y
> CONFIG_PINCTRL_EQUILIBRIUM=y
> CONFIG_DMABUF_SELFTESTS=y
> CONFIG_COMEDI=y
> CONFIG_XIL_AXIS_FIFO=y
> CONFIG_EXFAT_FS=y
> CONFIG_STM_DUMMY=y
> CONFIG_FSI_MASTER_ASPEED=y
> CONFIG_JFS_FS=y
> CONFIG_UBIFS_FS=y
> CONFIG_CRAMFS=y
> CONFIG_CRYPTO_DEV_SAFEXCEL=y
> CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
> CONFIG_KCOV=y
> CONFIG_LKDTM=y
> CONFIG_REED_SOLOMON_TEST=y
> CONFIG_TEST_RHASHTABLE=y
> CONFIG_TEST_MEMINIT=y
> CONFIG_NETWORK_PHY_TIMESTAMPING=y
> 
> This patchset attempts to deal with CONFIG_STATIC_LINK=y and
> CONFIG_UML_NET_PCAP=y by just removing them since they are broken and
> appear to have been broken for some time. (I am aware of the taboo of
> dropping configs, but given the amount of time they have been broken, I
> figured that I might be able to get away with it in this case, which is
> easier than trying to actually fix them.)
> 
> I also have a patch out to fix CONFIG_EXFAT_FS=y[2].
> 
> After this I plan on going after
> 
> CONFIG_PINCTRL_EQUILIBRIUM=y
> CONFIG_MTD_NAND_CADENCE=y
> CONFIG_FSI_MASTER_ASPEED=y
> CONFIG_CRYPTO_DEV_SAFEXCEL=y
> CONFIG_XIL_AXIS_FIFO=y
> CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
> CONFIG_XILINX_AXI_EMAC=y
> 
> the problem with these is that they depend on
> devm_platform_ioremap_resource without explicitly depending on
> CONFIG_HAS_IOMEM=y.
> 
> Also note that I don't think that CONFIG_NULL_TTY=y is actually broken
> on UML; however, console seems to get assigned to the null TTY by
> default when it is enabled, so I added it to the list for the sake of
> completeness.
> 
> The other broken configs require more investigation (I would welcome
> help, if anyone is interested ;-) ).
> 
> # Why won't allyesconfig break again after this series of fixes?
> 
> As I mentioned above, I am using UML for testing the kernel, and I am
> currently working on getting my tests to run on KernelCI. As part of our
> testing procedure for KernelCI, we are planning on building a UML kernel
> using allyesconfig and running our tests on it. Thus, we will find out
> very quickly once someone breaks allyesconfig again once we get this all
> working.
> 
> Brendan Higgins (2):
>    um: drivers: remove support for UML_NET_PCAP
>    uml: remove support for CONFIG_STATIC_LINK
> 
>   arch/um/Kconfig              |  23 +----
>   arch/um/Makefile             |   3 +-
>   arch/um/drivers/Kconfig      |  16 ----
>   arch/um/drivers/Makefile     |  17 +---
>   arch/um/drivers/pcap_kern.c  | 113 ----------------------
>   arch/um/drivers/pcap_user.c  | 137 ---------------------------
>   arch/um/drivers/pcap_user.h  |  21 -----
>   arch/um/kernel/dyn.lds.S     | 170 ----------------------------------
>   arch/um/kernel/uml.lds.S     | 115 -----------------------
>   arch/um/kernel/vmlinux.lds.S | 175 ++++++++++++++++++++++++++++++++++-
>   10 files changed, 174 insertions(+), 616 deletions(-)
>   delete mode 100644 arch/um/drivers/pcap_kern.c
>   delete mode 100644 arch/um/drivers/pcap_user.c
>   delete mode 100644 arch/um/drivers/pcap_user.h
>   delete mode 100644 arch/um/kernel/dyn.lds.S
>   delete mode 100644 arch/um/kernel/uml.lds.S
> 
> Looking forward to hearing people's thoughts!
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=205223
> [2] https://patchwork.kernel.org/patch/11273771/
> 

Patch for pcap: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=938962#79


-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
