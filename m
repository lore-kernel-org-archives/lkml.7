Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0894FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6497F21848
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="gb5sgjEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502123AbfJQLpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:45:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36871 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502103AbfJQLpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:45:02 -0400
Received: by mail-lj1-f193.google.com with SMTP id l21so2207457lje.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 04:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WP3ebuh7sgKEELQcpgEbN/gzP8uJWNJwh0VxumxieOE=;
        b=gb5sgjEAi5RRg8xOWG8bgXIAwcdIPyZoeUH5NAQDRATkjJCOxwIKQBjjf6D7JwCMB5
         8Bh0SSO1AbugOe0Y8BBEKjW4sMQwGY46RqJcbVcSzCtTdQFEkeNENNO5x0r/Ynz5gGQt
         zVL4AppMZlQBZ+yYKRjNoD+1GRGoNUNlq0fCrNGGz1bF+Vurv4Z67Id5sqqufT0vY8Zn
         i+u2p0pLNw/H2DJ1BZ7VCyTJWYUJaZyAjc1/mzHnaXQXq/k2O6S/TUwkYmY2ZTjXtrKi
         Dnrf/Trfd7OQUt7HOc6zXdUKV64yL/D+AoTF7qpgQzvR7SHRAO1pKVq8RbgfjsUgrrK5
         ZHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WP3ebuh7sgKEELQcpgEbN/gzP8uJWNJwh0VxumxieOE=;
        b=JTp57Nj0vr8N3nWQ+Ua7UUKcfEHTAZq0tqF5YTySP9EaAU4EVZBsPuoXs+yjh+jvV8
         Vz67e4Y0diJRZ+KGuVTO0ZY/2esKq+oUHfxJ8v563JmQkE1/OzrjnAvqM5Sb7iJKfU8G
         uafZ/ic3PDefoK9Zl5NPKlEpPO43EGW5x9XE3qm644QtTx9pvqTbU+pvZDymdOqbeo8W
         UkYy4Xvot47gk4jbbuLvwp651WAf15v43U+gJyart0y/mKO3YPeNlo3zo+lVIwkFzYBf
         Bi/tJF0I7cNQnJVG9yZjpYyZ2ALne1toQlN2JrmAbKhEZ24jS5OskE1iOx5cDJTj9XWg
         ZPIw==
X-Gm-Message-State: APjAAAWcoaD56Ot34yBXyP7DeqPAgRRqjnee2ZzpmQGlHgNwt/R42wDA
        9mcS5msc7Kpu+F5uEqG50n/TxA==
X-Google-Smtp-Source: APXvYqzTqIQzOWMja1Bd9eCdre1/gu/YFXK64B6rsBOXZvKdbkSxJTcFxkghMY2qeHv9KKobqzWAhg==
X-Received: by 2002:a2e:8852:: with SMTP id z18mr2329179ljj.230.1571312700640;
        Thu, 17 Oct 2019 04:45:00 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t24sm900286ljc.23.2019.10.17.04.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 04:44:59 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 975F51001A2; Thu, 17 Oct 2019 14:44:58 +0300 (+03)
Date:   Thu, 17 Oct 2019 14:44:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dan.j.williams@intel.com, keith.busch@intel.com
Subject: Re: [PATCH 1/4] node: Define and export memory migration path
Message-ID: <20191017114458.x4atu3vy7ogddvbm@box>
References: <20191016221148.F9CCD155@viggo.jf.intel.com>
 <20191016221149.74AE222C@viggo.jf.intel.com>
 <20191017111205.krurdatuv7d4brs4@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017111205.krurdatuv7d4brs4@box>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 02:12:05PM +0300, Kirill A. Shutemov wrote:
> > +		spin_lock(&node_migration_lock);
> > +		WRITE_ONCE(node_migration[nid], TERMINAL_NODE);
> > +		spin_unlock(&node_migration_lock);
> > +		return count;
> > +	}
> > +	if (next >= MAX_NUMNODES || !node_online(next))
> > +		return -EINVAL;
> 
> What prevents offlining after the check?

And what is story with memory hotplug interaction? I don't see any hooks
into memory hotplug to adjust migration path on offlining. Hm?

-- 
 Kirill A. Shutemov
