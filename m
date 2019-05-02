Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9D2C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6CB2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Pp94zrZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfEBFUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 01:20:53 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33171 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfEBFUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 01:20:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id j11so924378lfm.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 22:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIi/hOFHGvpdd8ZxHC2xGumiE5Qm52H/+YsyA0Mp3wc=;
        b=Pp94zrZbK8g3TalKL/jsZNRTt4pXPht0+i7KnoqIMY9/CC4a0DOOp60lnG4VzQdpXF
         hVZxgfHMGyg3FMIAbiJq8apr5Rz/rGk4gH+RXUOU6jcsVkUpxt15xJbHkWIOIUJOdcFB
         bmzSzgOHdBlw3iYDI1J312zA29wxcay3MlZEpJDOPSpFeF1GIeWIxmx2Due3K1zH7cjm
         6EFPcChVg2PlyIadjhmY31ovtv3rj2w1oVl8L1SSxMSg5qFmSJ1paDXBolf0DE6bmly4
         AfdA6ti/fUfFvktiqUW06QgHrPC1cfZFi7IGK9YjSSUNSy49agm0LRhuHLDuZZJrPh67
         +43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIi/hOFHGvpdd8ZxHC2xGumiE5Qm52H/+YsyA0Mp3wc=;
        b=dNERbC2bQc1u1MylqrCSU3Mbi3G3uNhHwga6YFoqEHz3E18xkGAEmjqHAy/Ab7Ll9L
         qiPnlNWlxf89ztIvT3bnwuFGQTeoPiYyNQ80WKmpDMQRnVMDbZvBIPOEmBe6X1CT6RkM
         +3Qzk8mOWcnCUFJ3L/c6XupfMBNK5QdpClXGS3kaZ5QmxgwL+5LTX3qhOwdxnTegaDNQ
         1cjyq29digSWirCw4mCOaa2mBTd1oMmDwSMHZDn9Szy3lpDt3ukfolXanziSBbRmOPqP
         Fi99eI3q6iQ5IaWYFtdEi3mj8qJ8qotYR3KKaZFpwEK46R5d9Ve1WuyjIgzyCGgZ/agy
         fw6g==
X-Gm-Message-State: APjAAAXe5cGxTvGAE8JLM+mI8tri6pdYDOJawxsHIFYxUV1/QdoEywqf
        OzK3UkIblI7MZwKIsINVBT9EhN4/vVIAfJLbkSiMyQ==
X-Google-Smtp-Source: APXvYqyUKgaXM4W3YewgggLouSmykoq3FIjWnoOWlifWkKdw/pR1z5cvvAGH8YKyQ4juApeiaTeRw96w/nvv+ylB6dQ=
X-Received: by 2002:a19:1dc3:: with SMTP id d186mr455221lfd.101.1556774449622;
 Wed, 01 May 2019 22:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <1556171696-7741-1-git-send-email-yash.shah@sifive.com>
 <1556171696-7741-2-git-send-email-yash.shah@sifive.com> <20190425101318.GA8469@e107155-lin>
 <CAJ2_jOEBqBnorz9PcQp72Jjju9RX_P8mU=Gq+0xCCcWsBiJksw@mail.gmail.com>
 <20190426093358.GA28309@e107155-lin> <CAJ2_jOEoD=Njp+L+H=jG59mA-j9SnwzyNmz7ECogWmbvei_f5Q@mail.gmail.com>
 <20190502004130.GA20802@bogus>
In-Reply-To: <20190502004130.GA20802@bogus>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Thu, 2 May 2019 10:50:12 +0530
Message-ID: <CAJ2_jOETZa_oC-xSwfQVw-9Q6OivRG2R0rKMhwCk1knbxWJQVw@mail.gmail.com>
Subject: Re: [PATCH 1/2] RISC-V: Add DT documentation for SiFive L2 Cache Controller
To:     Rob Herring <robh@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        mark.rutland@arm.com, Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 6:11 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Apr 30, 2019 at 09:50:45AM +0530, Yash Shah wrote:
> > On Fri, Apr 26, 2019 at 3:04 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Fri, Apr 26, 2019 at 11:20:17AM +0530, Yash Shah wrote:
> > > > On Thu, Apr 25, 2019 at 3:43 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > >
> > > > > On Thu, Apr 25, 2019 at 11:24:55AM +0530, Yash Shah wrote:
> > > > > > Add device tree bindings for SiFive FU540 L2 cache controller driver
> > > > > >
> > > > > > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > > > > > ---
> > > > > >  .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 53 ++++++++++++++++++++++
> > > > > >  1 file changed, 53 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> > > > > > new file mode 100644
> > > > > > index 0000000..15132e2
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> > > > > > @@ -0,0 +1,53 @@
> > > > > > +SiFive L2 Cache Controller
> > > > > > +--------------------------
> > > > > > +The SiFive Level 2 Cache Controller is used to provide access to fast copies
> > > > > > +of memory for masters in a Core Complex. The Level 2 Cache Controller also
> > > > > > +acts as directory-based coherency manager.
> > > > > > +
> > > > > > +Required Properties:
> > > > > > +--------------------
> > > > > > +- compatible: Should be "sifive,fu540-c000-ccache"
> > > > > > +
> > > > > > +- cache-block-size: Specifies the block size in bytes of the cache
> > > > > > +
> > > > > > +- cache-level: Should be set to 2 for a level 2 cache
> > > > > > +
> > > > > > +- cache-sets: Specifies the number of associativity sets of the cache
> > > > > > +
> > > > > > +- cache-size: Specifies the size in bytes of the cache
> > > > > > +
> > > > > > +- cache-unified: Specifies the cache is a unified cache
> > > > > > +
> > > > > > +- interrupt-parent: Must be core interrupt controller
> > > > > > +
> > > > > > +- interrupts: Must contain 3 entries (DirError, DataError and DataFail signals)
> > > > > > +
> > > > > > +- reg: Physical base address and size of L2 cache controller registers map
> > > > > > +
> > > > > > +- reg-names: Should be "control"
> > > > > > +
> > > > >
> > > > > It would be good if you mark the properties that are present in DT
> > > > > specification and those that are added for sifive,fu540-c000-ccache
> > > >
> > > > I believe there isn't any property which is added explicitly for
> > > > sifive,fu540-c000-ccache.
> > > >
> > >
> > > reg and interrupts are generally optional for normal cache and may be
> > > required for cache controller like this. DT specification[1] covers
> > > only caches and not cache controllers.
> >
> > Are you suggesting something like this:
> >
> > Required Properties:
> > --------------------
> > Standard Properties:
>
> I don't think we need this separation.

Ok. Won't include this "Standard/Non-standard properties" separation
in the next revision of this patch.

>
> > - cache-block-size: Specifies the block size in bytes of the cache
> >
> > - cache-level: Should be set to 2 for a level 2 cache
> >
> > - cache-sets: Specifies the number of associativity sets of the cache
> >
> > - cache-size: Specifies the size in bytes of the cache
>
> What are the possible valid values for these? That's what's important.
> What the properties mean are already defined in the spec.

Sure, will mention the valid values for these properties.

>
> >
> > - cache-unified: Specifies the cache is a unified cache
> >
> > Non-Standard Properties:
>
> I wouldn't call these non-standard.
>
> > - interrupt-parent: Must be core interrupt controller
>
> This is implied.

Will remove this redundant description.

>
> > - reg: Physical base address and size of L2 cache controller registers map
> >
> > - reg-names: Should be "control"
>
> -names is not really needed when there is only 1 entry.

Will remove this property.

>
> >
> > - Yash
> > >
> > > --
> > > Regards,
> > > Sudeep
> > >
> > > [1] https://github.com/devicetree-org/devicetree-specification/releases/download/v0.2/devicetree-specification-v0.2.pdf
