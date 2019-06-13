Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5D1C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1426820644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EPdR4Uv2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392606AbfFMQgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:36:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54954 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730674AbfFMH2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RWs47MlEw6q4mhAqwnkkTjDMHRGkSPNW49ybL3tYviI=; b=EPdR4Uv2CiGNsnqefLIJy0soy
        LuZo/5qJ+nSAnqBeloRkXbnC8QkRnvDaOnLLGlEyPfjV7rKDb+2IsSDnGpPPwR5YN+JsJZvE6Nzih
        h4bh6Hhrspi61r0s/Hu4diTce8cxLQZOlmsN8GF3gvQLewUG5UZZnnds/KRNZrSzpBBd2tlrz/+8z
        ZaOWCIT5Vq3o9xcR44US4mqjTGAzEYvXYCQMxeOJQ1RDU8UxVl8E9B0/2tTmgBOs4Vl4f4Kg35qtg
        BBXzZrj3MYp5SLkYoyyZ/9b1hHXnW1olZVdW8mjqDD1Jt3ArD9oGoZJO0zuuD4ObY35lWyRjv42XX
        Kkuaol0Ug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hbKA5-0002CN-VA; Thu, 13 Jun 2019 07:28:41 +0000
Date:   Thu, 13 Jun 2019 00:28:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
Subject: Re: [PATCH 10/12] bcache: move closures to lib/
Message-ID: <20190613072841.GA7996@infradead.org>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <20190610191420.27007-11-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610191420.27007-11-kent.overstreet@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 03:14:18PM -0400, Kent Overstreet wrote:
> Prep work for bcachefs - being a fork of bcache it also uses closures

NAK.  This obsfucation needs to go away from bcache and not actually be
spread further, especially not as an API with multiple users which will
make it even harder to get rid of it.
