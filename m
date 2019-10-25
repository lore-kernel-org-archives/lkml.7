Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C557CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EE320867
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="QrKWgESw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404282AbfJYGKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:10:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54968 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394262AbfJYGKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:10:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id g7so699967wmk.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 23:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=UZtQcpZNm2bgRElTtB0/YYRtxpmigD0UWuciJCpp5gM=;
        b=QrKWgESwGfrtCnkB4ANF4RDTIvZX+3mgrn+F048ehqIGeg2PIMapuhi5B29YdIPJRF
         OuF/1XgB1E3hujF7fmLSGOWHCpq+9DlFVEduBO8ipDdnjmiangiskHjwO3FsA7j8x1KD
         1Smuo6qnW1seJDFFROI5kLkQKHJzW7j8nL7QRsx6D6T92OoNZE6hSbJWqfQ2kzquPzUV
         EGGwKGRq2Dt/b39DcGka7dZFK17Wt7MIOIDReJEBLetmCZXSMWSBNVp4MthobvqT9E3G
         LimR87SPwJ5FuFVOpPQc3/2WoUZLiJcnk52cJ7R4bO2cA7rCH/FuOM9im/yZQR0mR3/u
         6apw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=UZtQcpZNm2bgRElTtB0/YYRtxpmigD0UWuciJCpp5gM=;
        b=qGc+sSUvxMVnhAo406+yb/0bMMfYoUvq9tPcphUv18+2Lo3jfgFAnYMLdlE721Pcgt
         /PYngINE/iJ+S1d/Zk4EdLq44gVJWRDYg75vIDmOpAIwSpDcrTIqHDI7lxX8mqVSvmZ8
         FfPd2CK5Oy8u6VMFxLHT+4r19uuSmn+CtsIZQ7iGtJpjcumSUcuJMue6iOax4PIEOccm
         c0lL65fMW323ZcnZ1IJmkypujKtJA8vxKgo05vjTNE4U50mXdu/6kXBTNYFnJPsINpNq
         VDeee5HuQNNLMmPZHu7qYtlFXA/mtB9k55VGld55Zh0DRRx+XrFPWMZiZqnNgF420tcs
         FcRA==
X-Gm-Message-State: APjAAAUa5CMDkJ7d8A18SvKGWgicFHksyMs+tX3K6bpUU50guTKBpr7b
        GYDC1oHJovCTbr2oTjfp17EdotnhIxghvqO5
X-Google-Smtp-Source: APXvYqwEgYO6Ro5u2lCKSVB90BazD7V/pF/lyQv5RjmcJQ3shOXOE39URbi4sRXKy/2ygEnJau+JXA==
X-Received: by 2002:a7b:c924:: with SMTP id h4mr1846926wml.46.1571983844471;
        Thu, 24 Oct 2019 23:10:44 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id k24sm6458006wmi.1.2019.10.24.23.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 23:10:43 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, palmer@sifive.com,
        hch@infradead.org, longman@redhat.com, helgaas@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Jackie Liu <liuyun01@kylinos.cn>,
        Wesley Terpstra <wesley@sifive.com>,
        Firoz Khan <firoz.khan@linaro.org>, sparclinux@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        James Hogan <jhogan@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Paul Burton <paul.burton@mips.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-snps-arc@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-mips@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/2] Enabling MSI for Microblaze
Date:   Fri, 25 Oct 2019 08:10:36 +0200
Message-Id: <cover.1571983829.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

these two patches come from discussion with Christoph, Bjorn, Palmer and
Waiman. The first patch was suggestion by Christoph here
https://lore.kernel.org/linux-riscv/20191008154604.GA7903@infradead.org/
The second part was discussed
https://lore.kernel.org/linux-pci/mhng-5d9bcb53-225e-441f-86cc-b335624b3e7c@palmer-si-x1e/
and
https://lore.kernel.org/linux-pci/20191017181937.7004-1-palmer@sifive.com/

Thanks,
Michal

Changes in v2:
- Fix typo in commit message s/expect/except/ - Reported-by: Masahiro

Michal Simek (1):
  asm-generic: Make msi.h a mandatory include/asm header

Palmer Dabbelt (1):
  pci: Default to PCI_MSI_IRQ_DOMAIN

 arch/arc/include/asm/Kbuild     | 1 -
 arch/arm/include/asm/Kbuild     | 1 -
 arch/arm64/include/asm/Kbuild   | 1 -
 arch/mips/include/asm/Kbuild    | 1 -
 arch/powerpc/include/asm/Kbuild | 1 -
 arch/riscv/include/asm/Kbuild   | 1 -
 arch/sparc/include/asm/Kbuild   | 1 -
 drivers/pci/Kconfig             | 2 +-
 include/asm-generic/Kbuild      | 1 +
 9 files changed, 2 insertions(+), 8 deletions(-)

-- 
2.17.1

