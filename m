Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DFDC10F13
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0277D2073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNJ5jFKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbfDQAUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 20:20:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42673 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfDQAUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 20:20:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id p20so25468040qtc.9;
        Tue, 16 Apr 2019 17:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Jo76j3RPCgAnrGa/TiEbcuBIjAHdGjV4OMd1AJEgU+4=;
        b=RNJ5jFKsZnU9/JtNFh5REUANx8dWKn/veh9lqiV9RoGengmlqDNw6yPEnxckSAigBL
         cAuKGljIz32ZIkIxv+NlX7Ox5T/CmFrHMWFS4LN0E35sZws5W2f8Cxa5DB8NIwF2HYt3
         TETzeekKBLw2klt+7Flr+wLNgRB8J8V7BEgbcyhB+mFRSA09t0TN61mQFkvxhyJOJqiT
         IrVEp1gQkfhyjeydAZEeyYmXmj4knfz/G6FcUN6IK/tt7QZG3G+mk6jfM9TS8GdpODUK
         kxZjeGcR+jdJM9MBEarnjK8iF+1XIEpRfoejdBelcx9KgSK4S830SlAS+ROsPbiC/FPj
         p7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Jo76j3RPCgAnrGa/TiEbcuBIjAHdGjV4OMd1AJEgU+4=;
        b=KnqrIiQPXWeheK5PApiQaYDvBLUSItO2+1EegmXGklTEMRoSZrjaqtKeV4OvgiO7Ot
         tI3g87c0v0RphiZWhWIvhgjWvwNdy601iZLye1qY4pt/yIi7MpSWKIYEsvS+rZ396Qh8
         di32nnuSIU29cIs1+ikfLKG4nur2qT7QJ9VunROWtvP0HT5HjqfhjJFLwehp/xKhLAmo
         v2Zkd+11vvExoh1t7oUFg/OEBUr8Rfi2Vn1o1nNe9CMqZT1i7mEeT5979O7iSVbPvzsV
         8Kz03TarzVHewwUWX36Ryjw7Oi8Zws2CuwroDc74uTtyzeLWFfG/FzrBGkE6UBf6NAQ1
         jdtg==
X-Gm-Message-State: APjAAAVkG+1t9jqRSjgYPc8JMzTI90GpsRZVnZSUETNrFzeeEUEjLDsD
        Nbu0zN+DIV2OYEEXHMegsDo=
X-Google-Smtp-Source: APXvYqyM+r1KuIBzi626YDSubSxe3803s6HLf5O0drtp/WYUkWllJpbNCDFNUIy6HklhPnA3rc7S3Q==
X-Received: by 2002:ac8:18d3:: with SMTP id o19mr68296935qtk.139.1555460411776;
        Tue, 16 Apr 2019 17:20:11 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id x8sm34028225qtj.45.2019.04.16.17.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 17:20:10 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B4E994039C; Tue, 16 Apr 2019 21:20:06 -0300 (-03)
Date:   Tue, 16 Apr 2019 21:20:06 -0300
To:     dwarves@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>, Alexei Starovoitov <ast@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        David Seifert <soap@gentoo.org>,
        Pavel Borzenkov <pavel.borzenkov@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Mark Wieelard <mjw@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ANNOUNCE: pahole v1.13 (More BTF, __aligned__, __packed__)
Message-ID: <20190417002006.GA13028@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	The v1.13 release of pahole and its friends is out, available at
the usual places:

Main git repo:

  git://git.kernel.org/pub/scm/devel/pahole/pahole.git

Mirror git repo:

  https://github.com/acmel/dwarves.git

tarball + gpg signature:

  https://fedorapeople.org/~acme/dwarves/dwarves-1.13.tar.xz
  https://fedorapeople.org/~acme/dwarves/dwarves-1.13.tar.sign

Here is a summary of changes:

- BTF

  - Use of the recently introduced BTF deduplication algorithm present in the
    Linux kernel's libbpf library, which allows for all the types in a multi
    compile unit binary such as vmlinux to be compactly stored, without duplicates.

    E.g.: from roughly:

    $ readelf -SW ../build/v5.1-rc4+/vmlinux | grep .debug_info.*PROGBITS
      [63] .debug_info PROGBITS 0000000000000000 1d80be0 c3c18b9 00 0 0 1
    $
    195 MiB

    to:

    $ time pahole --btf_encode ../build/v5.1-rc4+/vmlinux 
    real    0m19.168s
    user    0m17.707s         # On a Lenovo t480s (i7-8650U) SSD
    sys     0m1.337s
    $

    $ readelf -SW ../build/v5.1-rc4+/vmlinux | grep .BTF.*PROGBITS
      [78] .BTF        PROGBITS 0000000000000000 27b49f61 1e23c3 00 0 0 1
    $ 
    ~2 MiB

  - Introduce a 'btfdiff' utility that prints the output from DWARF and from
    BTF, comparing the pretty printed outputs, running it on various linux
    kernel images, such as an allyesconfig for ppc64.

    Running it on the above 5.1-rc4+ vmlinux:

      $ btfdiff ../build/v5.1-rc4+/vmlinux
      $ 

    No differences from the types generated from the DWARF ELF sections to the
    ones generated from the BTF ELF section.

  - Add a BTF loader, i.e. 'pahole -F btf' allows pretty printing of structs
    and unions in the same fashion as with DWARF info, and since BTF is way
    more compact, using it is much faster than using DWARF.

      $ cat ../build/v5.1-rc4+/vmlinux > /dev/null
      $ perf stat -e cycles pahole -F btf ../build/v5.1-rc4+/vmlinux  > /dev/null
      
       Performance counter stats for 'pahole -F btf ../build/v5.1-rc4+/vmlinux':
      
             229,712,692      cycles:u                                                    
             0.063379597 seconds time elapsed
             0.056265000 seconds user
             0.006911000 seconds sys
      
      $ perf stat -e cycles pahole -F dwarf ../build/v5.1-rc4+/vmlinux  > /dev/null
      
       Performance counter stats for 'pahole -F dwarf ../build/v5.1-rc4+/vmlinux':
      
          49,579,679,466      cycles:u                                                    
            13.063487352 seconds time elapsed
            12.612512000 seconds user
             0.426226000 seconds sys
      $

- Better union support:

  - Allow unions to be specified in pahole in the same fashion as structs

    $ pahole -C thread_union ../build/v5.1-rc4+/net/ipv4/tcp.o
    union thread_union {
            struct task_struct task __attribute__((__aligned__(64))); /* 0 11008 */
            long unsigned int          stack[2048];                   /* 0 16384 */
    };
    $

- Infer __attribute__((__packed__)) when structs have no alignment holes
  and violate basic types (integer, longs, short integer) natural alignment
  requirements. Several heuristics are used to infer the __packed__
  attribute, see the changeset log for descriptions.

  $ pahole -F btf -C boot_e820_entry ../build/v5.1-rc4+/vmlinux
  struct boot_e820_entry {
          __u64             addr;     /*     0     8 */
          __u64             size;     /*     8     8 */
          __u32             type;     /*    16     4 */

	/* size: 20, cachelines: 1, members: 3 */
	/* last cacheline: 20 bytes */
  } __attribute__((__packed__));
  $ 

  $ pahole -F btf -C lzma_header ../build/v5.1-rc4+/vmlinux
  struct lzma_header {
          uint8_t                    pos;                  /*     0     1 */
          uint32_t                   dict_size;            /*     1     4 */
          uint64_t                   dst_size;             /*     5     8 */

          /* size: 13, cachelines: 1, members: 3 */
          /* last cacheline: 13 bytes */
  } __attribute__((__packed__));

- Support DWARF5's DW_AT_alignment, which, together with the __packed__
  attribute inference algorithms produce output that, when compiled, should
  produce structures with layouts that match the original source code.

  See it in action with 'struct task_struct', which will also show some of the
  new information at the struct summary, at the end of the struct:

  $ pahole -C task_struct ../build/v5.1-rc4+/vmlinux | tail -19
  	/* --- cacheline 103 boundary (6592 bytes) --- */
  	struct vm_struct   * stack_vm_area;              /*  6592     8 */
  	refcount_t                 stack_refcount;       /*  6600     4 */
  
  	/* XXX 4 bytes hole, try to pack */
  
  	void *                     security;             /*  6608     8 */
  
  	/* XXX 40 bytes hole, try to pack */
  
  	/* --- cacheline 104 boundary (6656 bytes) --- */
  	struct thread_struct thread __attribute__((__aligned__(64))); /*  6656  4352 */
  
  	/* size: 11008, cachelines: 172, members: 207 */
  	/* sum members: 10902, holes: 16, sum holes: 98 */
  	/* sum bitfield members: 10 bits, bit holes: 2, sum bit holes: 54 bits */
  	/* paddings: 3, sum paddings: 14 */
  	/* forced alignments: 6, forced holes: 1, sum forced holes: 40 */
  } __attribute__((__aligned__(64)));
  $

- Add a '--compile' option to 'pfunct' that produces compileable output for the
  function prototypes in an object file. There are still some bugs but the vast
  majority of the kernel single compilation unit files the ones produced from a
  single .c file are working, see the new 'fullcircle' utility that uses this
  feature.

  Example of it in action:

  $ pfunct --compile=static_key_false ../build/v5.1-rc4+/net/ipv4/tcp.o  
  typedef _Bool bool;
  typedef struct {
  	int                        counter;              /*     0     4 */
  
  	/* size: 4, cachelines: 1, members: 1 */
  	/* last cacheline: 4 bytes */
  } atomic_t;
  
  struct jump_entry;
  
  struct static_key_mod;
  
  
  struct static_key {
  	atomic_t                   enabled;              /*     0     4 */
  
  	/* XXX 4 bytes hole, try to pack */
  
  	union {
  		long unsigned int  type;                 /*     8     8 */
  		struct jump_entry * entries;             /*     8     8 */
  		struct static_key_mod * next;            /*     8     8 */
  	};                                               /*     8     8 */
  
  	/* size: 16, cachelines: 1, members: 2 */
  	/* sum members: 12, holes: 1, sum holes: 4 */
  	/* last cacheline: 16 bytes */
  };
  
  bool static_key_false(struct static_key * key)
  {
  	return *(bool *)1;
  }
  
  $

The generation of compilable code from the type information and its use in the
new tool 'fullcircle, helps validate all the parts of this codebase, finding
bugs that were lurking forever, go read the csets to find all sorts of curious
C language features that are rarely seen, like unnamed zero sized bitfields and
the way people have been using it over the years in a codebase like the linux
kernel.

Certainly there are several other features, changes and fixes that I forgot to
mention! Now lemme release this version so that we can use it more extensively
together with a recent patch merged for 5.2:

  [PATCH bpf-next] kbuild: add ability to generate BTF type info for vmlinux

With it BTF will be always available for all the types of the kernel, which will
open a pandora box of cool new features that are in the works, and, for people
already using pahole, will greatly speed up its usage.

Please try to alias it to use btf, i.e.

   alias pahole='pahole -F btf'

Please report any problems you may find with this new version or with the BTF
loader or any errors in the layout generated/pretty printed.

Thanks to the fine BTF guys at Facebook for the patches and help in testing,
fixing bugs and getting this out of the door, the stats for this release are:

      Changesets: 157

      113 Arnaldo Carvalho de Melo       Red Hat
       32 Andrii Nakryiko                Facebook
       10 Yonghong Song                  Facebook
        1 Martin Lau                     Facebook
        1 Domenico Andreoli

- Arnaldo
