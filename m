Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09923C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF10E208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gwp4ceQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfHJIPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 04:15:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfHJIPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 04:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l/8ZpdSjNJGlaMRnpgRX93SKgxcJOiB3tmAP4Xrhmq8=; b=gwp4ceQoYX55nhYbf83A4kSEa
        aYGw/CmaBlPTk+bOPXYYuEsc3k7qy+jtCjB3ITwKDgZlaXjzhPxMZJQUDTBGzZjvUckXfTn4UtQTV
        xLXADSc9dfUPJvZeXAiX+W1dlrb40e496u+BcCoRon5bxaDSOD3wAYQYqwNUUVb5r8ZG+yXqKHpA1
        Xwp4T///NUInyMPkgCBRYjcvI5OLDYCBGHP9jj0HMgkxqtX9h8ZH8nwvvChqQ06Ks8rFCrJFYnW88
        xqMPStWVoKzp/AJUDXTz61Nl0xufX4u2Vk5boeHYowDlusWWlTUprAJ09GTPQCGlorJXRbf+cKwRy
        zuFu6rLPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hwMXM-0000C3-Qu; Sat, 10 Aug 2019 08:15:40 +0000
Date:   Sat, 10 Aug 2019 01:15:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     egranata@chromium.org
Cc:     linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, trivial@kernel.org, egranata@google.com
Subject: Re: [PATCH] vhost: do not reference a file that does not exist
Message-ID: <20190810081540.GA30426@infradead.org>
References: <20190808005255.106299-1-egranata@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808005255.106299-1-egranata@chromium.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 05:52:55PM -0700, egranata@chromium.org wrote:
> From: Enrico Granata <egranata@google.com>
> 
> lguest was removed from the mainline kernel in late 2017.
> 
> Signed-off-by: Enrico Granata <egranata@google.com>

But this particular file even has an override in the script looking
for dead references, which together with the content of the overal
contents makes me thing the dangling reference is somewhat intentional.
