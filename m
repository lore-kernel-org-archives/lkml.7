Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BBBC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7304D20678
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P18ypPHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391806AbfIQHhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 03:37:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfIQHhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+JXEYTnqyWlOW1rQWwizFJP/gYoExhOoqC5rCzivGV4=; b=P18ypPHaK51o7JCL7VL5koE7a
        JFRjwpGC6iR37jzkEtviCf3cIFCZ28m1RNUEs787tglr2bfrO94n7GJuXD1o8OyloaWzVtobMKaBk
        Cn5BgcuW6WmL+rig4Zhpnl1P30q0fojJXL7vCeHTqn3oOD9fily+nmIuth1WePCosx/SZ9x3D24zP
        iZPAvt0wyehpkJPCqtufmbiQ1vamNIgcapNDBc+yVXAOXasQvJYkM+512zsvtgKQaowPmwIzlOqC5
        ncemBECdGpjdi2WhEErvC3srT1yvd538WWf+WZk2pFlO0rjKXfaY4i/kPD3Cun6OZCAM7xam7E1PB
        /j0IUzejg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iA82h-0001Ud-Ec; Tue, 17 Sep 2019 07:36:55 +0000
Date:   Tue, 17 Sep 2019 00:36:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Allison Randal <allison@lohutok.net>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] ocxl: Add functions to map/unmap LPC memory
Message-ID: <20190917073655.GA31147@infradead.org>
References: <20190917014307.30485-1-alastair@au1.ibm.com>
 <20190917014307.30485-5-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917014307.30485-5-alastair@au1.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please submit this together with actual users instead of adding
dead code to the kernel.  Same for any of the previous bits
that arent used with our without this.
