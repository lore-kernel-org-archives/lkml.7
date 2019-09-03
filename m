Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC84C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 02:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3C622CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 02:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NYROjrDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfICCia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 22:38:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfICCi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 22:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=//Ea53kN5rE79WQGkQIGYNCPvD/egheDqPPhkUd4fxw=; b=NYROjrDDbZMFrJbuXg65KL4yE
        XY6uZgPHqEvyrXNqvhpZEMzIgtRuXkEsAHPihUjGXz6YkRmJEmSArhNQN3VbtoDvVAXfpAw+LCIl2
        nl7lVpnSG/OWG7j26uNhfRw2piBo5OG5eo68Siz/A6Jdafzi1CtFb1ed1SNp6F7CWAejwXkHEvONy
        eVQ/JcIql9XqPGnhYH8KM4ZuqhNojbLzWjdVJunbSEvjTsCrTm8sYaIZUbByUDjxTCglysouGtIJx
        KX5uLNWoJxj4RhDU2eICUZ8saSMP5quSugoHuKgtX6m3CANHd4Ddwx7LzRsAVG+OBL90x1ljUnD0V
        JQl5X+F+Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4yi6-0000V9-R1; Tue, 03 Sep 2019 02:38:22 +0000
Date:   Mon, 2 Sep 2019 19:38:22 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc:lock: remove reference to clever use of read-write
 lock
Message-ID: <20190903023822.GB29434@bombadil.infradead.org>
References: <20190831134116.25417-1-federico.vaga@vaga.pv.it>
 <2216492.xyESGPMPG3@pcbe13614>
 <20190902181010.GA35858@gmail.com>
 <4627860.yBeiQmOknq@harkonnen>
 <20190902142133.37e106af@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902142133.37e106af@lwn.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 02:21:33PM -0600, Jonathan Corbet wrote:
> On Mon, 02 Sep 2019 21:19:24 +0200
> Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> 
> > > > I am not used to the mathematical English jargon. It make sense, but then
> > > > I
> > > > would replace it with "If and only if": for clarity.  
> > > 
> > > While it's used in a number of places and it's pretty common wording
> > > overall in the literature, I agree that we should probably change this in
> > > locking API user facing documentation.  
> > 
> > I would say not only in locking/. The argument is valid for the entire 
> > Documentation/. I wait for Jon's opinion before proceeding.
> 
> I don't really have a problem with "iff"; it doesn't seem like *that*
> obscure a term to me.  But if you want spell it out, I guess I don't have
> a problem with that.  We can change it - iff you send a patch to do it :)

$ git grep -iwc iff Documentation
Documentation/admin-guide/cgroup-v1/blkio-controller.rst:1
Documentation/admin-guide/cgroup-v1/cgroups.rst:1
Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst:2
Documentation/admin-guide/cgroup-v2.rst:1
Documentation/devicetree/bindings/media/st-rc.txt:2
Documentation/devicetree/bindings/net/ibm,emac.txt:5
Documentation/devicetree/bindings/pinctrl/pinctrl-st.txt:1
Documentation/driver-api/libata.rst:1
Documentation/features/scripts/features-refresh.sh:1
Documentation/filesystems/directory-locking:1
Documentation/i2c/i2c-topology:3
Documentation/ioctl/hdio.rst:1
Documentation/locking/spinlocks.rst:1
Documentation/locking/ww-mutex-design.rst:1
Documentation/scsi/scsi_eh.txt:2
Documentation/spi/spidev:2
Documentation/trace/ring-buffer-design.txt:1
Documentation/virt/kvm/api.txt:1
Documentation/virt/kvm/halt-polling.txt:1

(29 total)

Of course that doesn't count any in kernel-doc.
