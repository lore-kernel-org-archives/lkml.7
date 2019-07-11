Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0056C742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2FA20872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfGKVA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 17:00:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45718 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfGKVA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 17:00:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id x22so987488qtp.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 14:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jKb42en0+xCYGb3da2EmIvLXkWw5dJPW2Cy3PpIEHNc=;
        b=pJPDNT7pzD1QKoy+9CRb3aSCLRq7+zADthZOaGWUyrHK/pQ0P951RjggF8GZvCjzq6
         kifefby/opXGP3kpYH1sn2JVVxM8zSZbioNzfRpPCeBpSYzoAFEZF4SOChw7p4CM/jqA
         FVtQzjJnAsBqI+tyG74UFLRBFyJcGs0Rs2na9bVkdxstxVypiS6urmfT5eyX6ZQ4XNPQ
         xQzvAaWrbDK39fVjb0NShikBa4j3Ecmz3zTuTuq6o9ocfxgx+eNq7UVqKNVpAXDyGbYE
         /+p8NPsHkeUmcTVdF3bO4BvaMRlg7u5Onhq84DW0NDokXHkoKij7Oh1wWgMfTF1/Nlkw
         WaMA==
X-Gm-Message-State: APjAAAUoqpJ169JphotqM6ezdWPbv81RI34PjsUZhiNJGcKKUpK/VKRa
        Gf4RJ0rQD9SXzSvRDjw58mKxWm0EbO97P6PFpjE=
X-Google-Smtp-Source: APXvYqwRtMtXMvTvxJF9angdyjOw6VsbVIGRGheo4HCexXu1ZtXMYeRWaiayBGc40BkyO2IcpHyd/j2A+3BwWy62qbs=
X-Received: by 2002:ac8:4996:: with SMTP id f22mr3345129qtq.142.1562878826607;
 Thu, 11 Jul 2019 14:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2beBPP+KX4zTfSfFPwo+7ksWZLqZzpP9BJ80iPecg3zA@mail.gmail.com>
 <20190711172621.a7ab7jorolicid3z@treble>
In-Reply-To: <20190711172621.a7ab7jorolicid3z@treble>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Jul 2019 23:00:09 +0200
Message-ID: <CAK8P3a0iOMpMW-dXUY6g75HGC4mUe3P3=gv447WZOW8jmw2Vgg@mail.gmail.com>
Subject: Re: objtool crashes on clang output (drivers/hwmon/pmbus/adm1275.o)
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 7:26 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, Jul 11, 2019 at 02:40:06PM +0200, Arnd Bergmann wrote:
> > During randconfig testing with clang-9, I came across an object file
> > that makes objtool segfault, see attachment. Let me know if you need
> > more information to
> > debug this.
> >
> > I also get a ton of objtool warnings building random configurations, but Nick
> > mentioned that there is still a bug related to asm-goto in the build I'm using
> > that may be the root cause. Once I have a fixed clang-9 build, I can have a look
> > at those as well.
>
> Seg fault fix:

Thanks for the fix! testing it over night now, will let you know tomorrow
if problems remain.

I wonder if this is also related to several warnings I get about switch
tables like:

drivers/usb/misc/sisusbvga/sisusb.o: warning: objtool:
sisusb_write_mem_bulk()+0x588: can't find switch jump table

drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.o:
warning: objtool: dce_mem_input_v_program_pte_vm()+0x46e: can't find
switch jump table
drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_opp_csc_v.o:
warning: objtool: dce110_opp_v_set_csc_default()+0x714: can't find
switch jump table
drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.o: warning: objtool:
nv50_clk_read()+0x15c: can't find switch jump table
drivers/media/dvb-frontends/cxd2880/cxd2880_tnrdmd_dvbt2.o: warning:
objtool: x_tune_dvbt2_demod_setting()+0x992: can't find switch jump
table
drivers/media/tuners/mt2063.o: warning: objtool:
MT2063_SetReceiverMode()+0x24d: can't find switch jump table
drivers/mmc/host/tifm_sd.o: warning: objtool: tifm_sd_exec()+0x7e:
can't find switch jump table
drivers/mtd/nand/raw/fsl_ifc_nand.o: warning: objtool:
fsl_ifc_nand_probe()+0x4c7: can't find switch jump table
drivers/net/can/at91_can.o: warning: objtool: at91_irq()+0x347: can't
find switch jump table
drivers/net/phy/phylink.o: warning: objtool:
phylink_mac_config()+0x2b5: can't find switch jump table
drivers/regulator/max8973-regulator.o: warning: objtool:
max8973_probe()+0x736: can't find switch jump table
drivers/regulator/tps80031-regulator.o: warning: objtool:
tps80031_regulator_probe()+0x143: can't find switch jump table
drivers/tty/cyclades.o: warning: objtool: cy_set_line_char()+0x86c:
can't find switch jump table
drivers/tty/serial/jsm/jsm_cls.o: warning: objtool: cls_param()+0x10b:
can't find switch jump table
drivers/tty/serial/jsm/jsm_neo.o: warning: objtool: neo_param()+0x151:
can't find switch jump table
drivers/usb/core/hub.o: warning: objtool: hub_probe()+0x920: can't
find switch jump table
drivers/usb/misc/sisusbvga/sisusb.o: warning: objtool:
sisusb_write_mem_bulk()+0x4db: can't find switch jump table
kernel/rcu/tree.o: warning: objtool: rcu_note_context_switch()+0x6b8:
can't find switch jump table
lib/zstd/decompress.o: warning: objtool:
ZSTD_decodeLiteralsBlock()+0x5e: can't find switch jump table

If you want to have a look, I can provide object files and/or reduced test
cases for this. My guess is that it is unrelated to the warnings that Nick
saw for asm-goto.

        Arnd
