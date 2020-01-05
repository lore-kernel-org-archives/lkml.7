Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3755CC00523
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 07:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0911121775
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 07:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578207766;
	bh=N3XRiR7CmsQsVRLAZucAVOasILmNQQtZLni2nmDCmMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=arpqb2kkZVFqFqGoAd4NwjXphiPjsggob9XhSsxSPOTt+J3I6/yBJJE4xlXPo6mrF
	 ISbKyZKsDYVSGmWI2HpXTRp646ypRTrK6yqWshro4GSwbsUBIxXiIN2MFtMXXgi6pq
	 V4Z3c7kRgQQRu0LpQjyscn3761BhXVplsYIi9ZS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgAEHCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 02:02:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgAEHCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 02:02:44 -0500
Received: from rapoport-lnx (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D18BF20866;
        Sun,  5 Jan 2020 07:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578207763;
        bh=N3XRiR7CmsQsVRLAZucAVOasILmNQQtZLni2nmDCmMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qeY1BTDvcMglSfXPB93lsmipOPUh4PNjZC6fWuH5QzMqHnAPA3+2hlmcdx+b1gRzJ
         lVvv+2qHHqoS5jJwn8LfdfPQ5omY1KB3swSZcxqQ0Nd5/OhBvhqlldib8qkKniVQEx
         DU4N5PvpX68p/g65Qjsoli11Bf62jl1BtfpwHj9g=
Date:   Sun, 5 Jan 2020 09:02:37 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: add support for folded p4d page tables
Message-ID: <20200105070236.GA7261@rapoport-lnx>
References: <20191209150908.6207-1-rppt@kernel.org>
 <20200102081059.GA12063@rapoport-lnx>
 <20200102174231.Horde.vA_c3sSHB1vhx2H9Ce-i9Q1@messagerie.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200102174231.Horde.vA_c3sSHB1vhx2H9Ce-i9Q1@messagerie.si.c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 05:42:31PM +0100, Christophe Leroy wrote:
> Mike Rapoport <rppt@kernel.org> a écrit :
> 
> >Any updates on this?
> 
> Checkpatch reported several points, see
> https://patchwork.ozlabs.org/patch/1206344/

Well, for the most part checkpatch is unhappy because I've tried to keep
the changes consistent with the old code. And, there are some lines over 90
characters that do no seem worth breaking.

> Christophe
> 
