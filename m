Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5528FC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 11:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217E821852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 11:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="F1MdffGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfIQLfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 07:35:51 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44101 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfIQLfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 07:35:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id p2so2960555edx.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 04:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lsk22gvjZCMJdeOTjo7vuiThcN13Ig8AekQjvKFWm+Y=;
        b=F1MdffGrMj+kDHDQ4wJ1RBHbjeHu+iO4CiQcJQ2Wj7f40nPxkfrdKG9sXChIE8hpV3
         ZU7LiZDNykYHaMdo0wS6o2euizIWecstXVGymmKn3BHsqRlPbLy6lrhxFLO5g87XC18t
         7xkWfSlSv7gUV2m5r3oQjFBcSzTDsoiv2NfzJGJQbGu1xRQ/EVbKT0HmYAwi5FWlZIXP
         zTLFI0UG8v0Fsr+uPIOCgRcT8ZhvT74Ik7akjKZIqbiMBNEYfOLh1bzFEdhPiUo0hh8h
         u1yWt45mnyG38I2kFxRxPduSJx4gmgMJKXX0GNLdfG90W7dZA++LfpNxF0nPi7p6uP9M
         Q7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lsk22gvjZCMJdeOTjo7vuiThcN13Ig8AekQjvKFWm+Y=;
        b=dLlaMdj1zUkQofWN+Y9P0DFHkUB8feEBYlYYboebIYTC9x6KgvIWt31uF2PdAEx+m0
         HvmuRdYcHOyraNROVo8BYfZvqxJ0+hpwx9JUdpu9mq1cUElDWBp9DJI5bc+wu40dDOD6
         nJ0+O6SfV8NhKENHivbWxJNTzpUTuPQZaum5GR73B03HAjXYxWvQLZOUlI0a9kXoeadn
         ALwkumP6aobK/KhIK+mk6yZ2oZgyz9qJnJahlKCo9kJ/XW7iag4JRRnmD3aPVjomhPgT
         nTal6bac1gQyNBPcWi6jQs8idPn2FFm6QF8zvn4LOmf8ZsX9M6S1AQm8M1UxnuYVLEc2
         szrQ==
X-Gm-Message-State: APjAAAXtOgNcDfo6VW4a2solyJLrS5K5/isY3td1BdWxawDVlHQUY+9D
        7G96jitY6ZeAEEeMvuiZ9pM4Ng==
X-Google-Smtp-Source: APXvYqzVkom/Reda5cx+Cvs0Wea5qXN61S7z9bisc/Jb3Q/OeNuKYua4459x4BEuMpZW/ppsQE3MDw==
X-Received: by 2002:a50:ab58:: with SMTP id t24mr4044256edc.131.1568720149355;
        Tue, 17 Sep 2019 04:35:49 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g6sm387555edk.40.2019.09.17.04.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 04:35:48 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 99944101C0B; Tue, 17 Sep 2019 14:35:50 +0300 (+03)
Date:   Tue, 17 Sep 2019 14:35:50 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Lucian Adrian Grijincu <lucian@fb.com>, linux-mm@kvack.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@fb.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v3] mm: memory: fix /proc/meminfo reporting for
 MLOCK_ONFAULT
Message-ID: <20190917113550.v6nool7oizht66fx@box>
References: <20190913211119.416168-1-lucian@fb.com>
 <20190916152619.vbi3chozlrzdiuqy@box>
 <20190917101519.GD1872@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917101519.GD1872@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 12:15:19PM +0200, Michal Hocko wrote:
> On Mon 16-09-19 18:26:19, Kirill A. Shutemov wrote:
> > On Fri, Sep 13, 2019 at 02:11:19PM -0700, Lucian Adrian Grijincu wrote:
> > > As pages are faulted in MLOCK_ONFAULT correctly updates
> > > /proc/self/smaps, but doesn't update /proc/meminfo's Mlocked field.
> > 
> > I don't think there's something wrong with this behaviour. It is okay to
> > keep the page an evictable LRU list (and not account it to NR_MLOCKED).
> 
> evictable list is an implementation detail. Having an overview about an

s/evictable/unevictable/

> amount of mlocked pages can be important. Lazy accounting makes this
> more fuzzy and harder for admins to monitor.
> 
> Sure it is not a bug to panic about but it certainly makes life of poor
> admins harder.

Good luck with making mlock accounting exact :P

For start, try to handle sanely trylock_page() failure under ptl while
dealing with FOLL_MLOCK.

> If there is a pathological THP behavior possible then we should look
> into that as well.

There's nothing pathological about THP behaviour. See "MLOCKING
Transparent Huge Pages" section in Documentation/vm/unevictable-lru.rst.

-- 
 Kirill A. Shutemov
