Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0688C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF52C206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNzWJlnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfK0Wzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 17:55:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53019 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726984AbfK0Wzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 17:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574895352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OkZZSn7UB7yAAoECEs1czq8fk4r+Na8nNcmoXP+YNQc=;
        b=QNzWJlnK5+CUrrmg3GwfmYuo+buR0eu0hImWEV63EaQCg0+CmtIOZw/RuKblS2E2+xX1Cv
        YS3aVjzyKQjwvHxXr+LOplPpBJaMllI7uhqAN6cZ2RJ+klAu8+Y6vsGipJefbZE7jjP7B0
        8a0h52hyphZnUFaoQ/VY0Uo3Kr3TCuk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-wOGEJGgtPwG6HhsNBc0GVg-1; Wed, 27 Nov 2019 17:55:45 -0500
Received: by mail-wm1-f71.google.com with SMTP id y14so2935535wmj.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 14:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ypXWC1p1rh6B0sqBKSPovHb8hFFh42IyChXftJmwFwA=;
        b=N8wFJMPp9jjHhme4GomoLJB7CXHcO+LRFFqOMjS/aXPbdqvB5LYrE+My+c4UeqOEV3
         9ZMiau9ap4NtSKh+dmxgBdJmX1LUUvfR3YnC970GYgIcga+kD2WzYSKBSEJuzbc3IJZA
         OwDEhsEU2Yw7uaWvzuBtSOg/IAOGhP3MzSL+niPVIwAJ2pbq+gWFw5SmgqYNc/yA8L32
         BttYjYLyjVP7l4Y85QIW0aP45+iTI9oxiBO3e8PnDvZRyg30nLSycCdrXsChWR63zUK2
         EaXQYA6U3HNCN3brNIo8it6SRSj4AVeDspB7CKkuqi2BFXkgqS5jI0vEFe7chEyCLl1J
         m9jA==
X-Gm-Message-State: APjAAAUtSu9sztnGRehG7WnbAZRc3Rfc4N7dayI0nE+Ubvs1ZEIvuZ7G
        YvB/DSvqnUBy1vLjp1M9FccPsNvy9PA6zASj8GkFAe02L2Xld08ENfCxp3eNCPd85FYnt/BxYmY
        dJ5I/iI/8tP2Px2/RP1+4aYAl
X-Received: by 2002:a7b:c844:: with SMTP id c4mr6439428wml.1.1574895344446;
        Wed, 27 Nov 2019 14:55:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqyIAv+FB8FoOGt06XxttDaljWDfDs6v8v8eSAU83EObkoTkmGHfwfYyoH4gt9sI1Da63D1u4w==
X-Received: by 2002:a7b:c844:: with SMTP id c4mr6439414wml.1.1574895344253;
        Wed, 27 Nov 2019 14:55:44 -0800 (PST)
Received: from ?IPv6:2a01:598:b889:7f36:a401:5177:c4ae:d2ba? ([2a01:598:b889:7f36:a401:5177:c4ae:d2ba])
        by smtp.gmail.com with ESMTPSA id g11sm8525862wmh.27.2019.11.27.14.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 14:55:43 -0800 (PST)
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] drivers/base/node.c: Simplify unregister_memory_block_under_nodes()
Date:   Wed, 27 Nov 2019 23:55:42 +0100
Message-Id: <13549413-C422-4661-9E7E-4DBC63B8997C@redhat.com>
References: <20191127141532.525708b65a96fd614595bae8@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Chris von Recklinghausen <crecklin@redhat.com>
In-Reply-To: <20191127141532.525708b65a96fd614595bae8@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: iPhone Mail (17A878)
X-MC-Unique: wOGEJGgtPwG6HhsNBc0GVg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 27.11.2019 um 23:15 schrieb Andrew Morton <akpm@linux-foundation.org>:
>=20
> =EF=BB=BFOn Wed, 27 Nov 2019 17:53:12 +0100 David Hildenbrand <david@redh=
at.com> wrote:
>=20
>> Just a note that this was actually also a bugfix as noted by Chris.
>>=20
>> If the memory we are removing was never onlined,
>> get_nid_for_pfn()->pfn_to_nid() will return garbage. Removing will
>> succeed but links will remain in place.
>>=20
>> Can be triggered by
>>=20
>> 1. hotplugging a DIMM to node 1
>> 2. not onlining the memory blocks
>> 3. unplugging it
>> 4. re-plugging it to node 1
>>=20
>> We will trigger the BUG_ON(ret) in add_memory_resource(), because
>> link_mem_sections() will return with -EEXIST.
>=20
> Oh.  In that case case we please redo the patch as a bugfix?=20
> Appropriate title and changelog?  And perhaps the bugfix can be split
> from the cleanup, to make the former more backportable?

This is already upstream (d84f2f5a7552 ),so I=E2=80=98m afraid we can=E2=80=
=98t do anything about it. (When your cleanups turn into bugfixes ...).

I can still try to send stable patches, though ...

