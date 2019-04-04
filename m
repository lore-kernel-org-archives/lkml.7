Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604E5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC1B204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554374706;
	bh=JDYpTwi1zuluXo/2/qUHJHPNhQgtig6DqOKGWlaHbLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LBEex+grpHoreLX0DfnuO0VT77oJ4WfuhXVKsyZ3nhH0/z/Zd7ZDRk1vlJfuNk85f
	 JAzXfQUy9m9JrO/6c5/Fw5tWUek2k3oKje8dBSY1UjP8jsJoVvFAfi67KmeZJOmy2D
	 WU4FprR1Az7gb5DqAGYheEOuPu1z4yUp0XJShBmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfDDKpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:45:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43075 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729087AbfDDKpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:45:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id f18so1617993lja.10;
        Thu, 04 Apr 2019 03:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XzQvjmCI+0ckfBthskpsNeqIbQ1X/pfU1z+CGkImJtk=;
        b=RtuLsBa6tCIA1w0fp5vR7zJYEkWtWZ3VNHStKdTQNae61fzBEJEaaMWuC7qdF3fD7O
         H9JlgtLBA2/gtq4+1tit7gIDGZjzJKjOPwWt55qWCmCaL6LFwuxQ1SaL1ywcEFbzi3ZT
         x8IgPCFpogoBZC/ibWUQxL17iXd7cfRaNvczHVSrKtF2MIHOZ+AGE8Jk/sZoErKihbwP
         Oo7kZglXojTBIZctE5FiiyyC2xCWrGFXJkYXgqjzD5DQ3JMYjgm/GQNQYIYbW7PubaP0
         2ay2+dkuKFHkOxPQiLNjWNQ1YwN0OE0uOzKtHvuGReuXrWQS4iQyMzHkq7QKuzhCMMyv
         v8HQ==
X-Gm-Message-State: APjAAAXjfdXo3JOCtpDxAkp08KsUo1QWFjXYMWnVDkZSfXBoslMfCsoj
        nIVtAnEI+LqVWcqKiWyKd8PD2fWD
X-Google-Smtp-Source: APXvYqwORWZXGxGhy46KAQGiLwD78jTEvIBFe2rl+z8abcRerNYwVGQCBViuZOp4DIp9ePOc1s2oYQ==
X-Received: by 2002:a2e:9703:: with SMTP id r3mr2944827lji.88.1554374702568;
        Thu, 04 Apr 2019 03:45:02 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id c64sm3531882lfg.70.2019.04.04.03.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 03:45:01 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hBzs6-0004U0-G7; Thu, 04 Apr 2019 12:45:26 +0200
Date:   Thu, 4 Apr 2019 12:45:26 +0200
From:   Johan Hovold <johan@kernel.org>
To:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
Cc:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        johan@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH v2 4/5] dt-bindings: gnss: Add
 u-blox,neo-6m compatible
Message-ID: <20190404104526.GD29917@localhost>
References: <20190401115616.21337-1-megous@megous.com>
 <20190401115616.21337-5-megous@megous.com>
 <20190401120209.fhjyvevk4tsc533s@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190401120209.fhjyvevk4tsc533s@core.my.home>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 02:02:09PM +0200, Ondřej Jirman wrote:
> On Mon, Apr 01, 2019 at 01:56:15PM +0200, megous via linux-sunxi wrote:
> > From: Ondrej Jirman <megous@megous.com>
> > 
> > Add compatible for u-blox NEO-6M GPS module.
> > 
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> 
> Ouch, I forgot to add:
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> I'll do v3 if necessary, for this.

Looks good to me too.

Now applied with Robs ack along with the ubx-driver patch.

Thanks,
Johan
