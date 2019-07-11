Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF911C742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 23:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEF320872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 23:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfGKXUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 19:20:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728968AbfGKXUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 19:20:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 649788665F;
        Thu, 11 Jul 2019 23:20:53 +0000 (UTC)
Received: from treble (ovpn-122-237.rdu2.redhat.com [10.10.122.237])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC93260BE2;
        Thu, 11 Jul 2019 23:20:51 +0000 (UTC)
Date:   Thu, 11 Jul 2019 18:20:49 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: objtool crashes on clang output (drivers/hwmon/pmbus/adm1275.o)
Message-ID: <20190711232049.dedqd665znnpfhrx@treble>
References: <CAK8P3a2beBPP+KX4zTfSfFPwo+7ksWZLqZzpP9BJ80iPecg3zA@mail.gmail.com>
 <20190711172621.a7ab7jorolicid3z@treble>
 <CAK8P3a0iOMpMW-dXUY6g75HGC4mUe3P3=gv447WZOW8jmw2Vgg@mail.gmail.com>
 <CAG48ez3ipuPHLxbqqc50=Kn4QuoNczkd7VqEoLPVd3WWLk2s+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez3ipuPHLxbqqc50=Kn4QuoNczkd7VqEoLPVd3WWLk2s+Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 11 Jul 2019 23:20:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 11:04:35PM +0200, Jann Horn wrote:
> On Thu, Jul 11, 2019 at 11:00 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Thu, Jul 11, 2019 at 7:26 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Thu, Jul 11, 2019 at 02:40:06PM +0200, Arnd Bergmann wrote:
> > > > During randconfig testing with clang-9, I came across an object file
> > > > that makes objtool segfault, see attachment. Let me know if you need
> > > > more information to
> > > > debug this.
> > > >
> > > > I also get a ton of objtool warnings building random configurations, but Nick
> > > > mentioned that there is still a bug related to asm-goto in the build I'm using
> > > > that may be the root cause. Once I have a fixed clang-9 build, I can have a look
> > > > at those as well.
> > >
> > > Seg fault fix:
> >
> > Thanks for the fix! testing it over night now, will let you know tomorrow
> > if problems remain.
> >
> > I wonder if this is also related to several warnings I get about switch
> > tables like:
> >
> > drivers/usb/misc/sisusbvga/sisusb.o: warning: objtool:
> > sisusb_write_mem_bulk()+0x588: can't find switch jump table
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.o:
> > warning: objtool: dce_mem_input_v_program_pte_vm()+0x46e: can't find
> > switch jump table
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_opp_csc_v.o:
> > warning: objtool: dce110_opp_v_set_csc_default()+0x714: can't find
> > switch jump table
> > drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.o: warning: objtool:
> > nv50_clk_read()+0x15c: can't find switch jump table
> > drivers/media/dvb-frontends/cxd2880/cxd2880_tnrdmd_dvbt2.o: warning:
> > objtool: x_tune_dvbt2_demod_setting()+0x992: can't find switch jump
> > table
> > drivers/media/tuners/mt2063.o: warning: objtool:
> > MT2063_SetReceiverMode()+0x24d: can't find switch jump table
> > drivers/mmc/host/tifm_sd.o: warning: objtool: tifm_sd_exec()+0x7e:
> > can't find switch jump table
> > drivers/mtd/nand/raw/fsl_ifc_nand.o: warning: objtool:
> > fsl_ifc_nand_probe()+0x4c7: can't find switch jump table
> > drivers/net/can/at91_can.o: warning: objtool: at91_irq()+0x347: can't
> > find switch jump table
> > drivers/net/phy/phylink.o: warning: objtool:
> > phylink_mac_config()+0x2b5: can't find switch jump table
> > drivers/regulator/max8973-regulator.o: warning: objtool:
> > max8973_probe()+0x736: can't find switch jump table
> > drivers/regulator/tps80031-regulator.o: warning: objtool:
> > tps80031_regulator_probe()+0x143: can't find switch jump table
> > drivers/tty/cyclades.o: warning: objtool: cy_set_line_char()+0x86c:
> > can't find switch jump table
> > drivers/tty/serial/jsm/jsm_cls.o: warning: objtool: cls_param()+0x10b:
> > can't find switch jump table
> > drivers/tty/serial/jsm/jsm_neo.o: warning: objtool: neo_param()+0x151:
> > can't find switch jump table
> > drivers/usb/core/hub.o: warning: objtool: hub_probe()+0x920: can't
> > find switch jump table
> > drivers/usb/misc/sisusbvga/sisusb.o: warning: objtool:
> > sisusb_write_mem_bulk()+0x4db: can't find switch jump table
> > kernel/rcu/tree.o: warning: objtool: rcu_note_context_switch()+0x6b8:
> > can't find switch jump table
> > lib/zstd/decompress.o: warning: objtool:
> > ZSTD_decodeLiteralsBlock()+0x5e: can't find switch jump table
> >
> > If you want to have a look, I can provide object files and/or reduced test
> > cases for this. My guess is that it is unrelated to the warnings that Nick
> > saw for asm-goto.
> 
> I was playing around with building the kernel with LLVM a few months
> ago and used this local patch, but didn't get around to submitting
> upstream because I couldn't reproduce the problem for some reason. I
> think the warnings you're getting sound like what I saw back then:
> https://gist.github.com/thejh/0434662728afb95d72455bf30ece5817
> 
> Quoting the commit message from that patch:
> 
> ====
> With clang from git master, code can be generated where a function contains
> two indirect jump instructions that use the same switch table. To deal with
> this case and similar ones properly, convert the switch table parsing to
> use two passes:
> ====
> 
> Does that sound like what you're seeing?

Thanks Jann, I like this approach.  Hopefully it also works with GCC.

The switch tables (and jump tables in general) have been a hot topic in
objtool lately.  I have several other patches pending which touch this
code.  I'll integrate your patch with the others and try to do some more
testing in GCC.

-- 
Josh
