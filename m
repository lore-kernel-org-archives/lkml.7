Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2C4C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C5D20679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565684620;
	bh=LhM0YKarXZmrtosEYHZKw3JO5KA+rrW+R4sA+dxYHo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EF7Qd7IipKq4VU97z13ZE1EHumfeXkoPKoPPZnIEoMTOxCS+dYu35Cdh03J26evY0
	 Olm3xAFX2xqqR5RjiFTkeGRz2J/OIpo7nJPv4A3WvYXKzHVMeykp8yJMWhlCrK20+I
	 Hf6nGQZqUkBpsjn/zSU912vQqFGGJa3klp5A/lE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfHMIXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:23:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbfHMIXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:23:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E618E20663;
        Tue, 13 Aug 2019 08:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565684618;
        bh=LhM0YKarXZmrtosEYHZKw3JO5KA+rrW+R4sA+dxYHo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xmY33onqh5s/0F6Nes4hp0T2wWMVFsQaxmazfIV2RL982CY2WeAYpOoF8h6kqDeD9
         Yyz6s1UfIANHyURdX3zrsq7tPGixoS7RNG5Ks7RSBiuJ3BYa3EJGad52XRjzLo8XwC
         at44eKlZCbmOxqbltAbKELSpiyAF0WY/JsSmtXWg=
Date:   Tue, 13 Aug 2019 10:23:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Knut Omang <knut.omang@oracle.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC 00/19] Integration of Kernel Test Framework (KTF) into the
 kernel tree
Message-ID: <20190813082336.GB17627@kroah.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 08:09:15AM +0200, Knut Omang wrote:
> and in the making::
> 
> kunit/			  (kernel only (UML))

You are going to have to integrate this with kunit, to come up with a
superset of both in the end.

And I do not think that kunit is only UML, it's just that seems to be
what Brendan tests with, but should work with other arches as well.

thanks,

greg k-h
