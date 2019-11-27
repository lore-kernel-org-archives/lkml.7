Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9519C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 19:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C232720835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 19:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+KbQX28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfK0Twr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:52:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58513 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726729AbfK0Twr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 14:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574884366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HiZS6oFfOA80v64mJWiWGLuKXjLnUu1+qmjApNcY1+g=;
        b=A+KbQX280HJaBRouFB5dZ/mJdzvdY//yTNxDjtxgzpaq3doPcstqXRqONocXU/ZjnyHyLQ
        tAz6zEfmRGwPwNo3XbB8wOoLb/4Yo2B6OftGWXTX5wfTHhhS0M4GoTdUd32GsNlUwkSi8V
        oMJeaBLK9QGxG2kPTpme2bD46SgZljY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-sNM1L5unPcmyRmOhb03aWA-1; Wed, 27 Nov 2019 14:52:42 -0500
Received: by mail-wm1-f71.google.com with SMTP id o135so2972344wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 11:52:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=+P1Iia7oLAHdhlzKG11woXJ5RZt0oWz8tr0zkXFxMMU=;
        b=Ds5vpQm48wbcaWqYqcbv476kYY4o1v/gNqRhaPbD0YJf7dLVEjnjP6Icl1WK/l8pex
         ANru2LS6B1gNjPiN4Sb3pIfKK204BKR0Kg9K+kOPEH8ajDbh7bfs65985ErmccThrKcu
         FqVieF4NB1spROHWnLn1OMywvF4KGcTuUKUCSnPr6GN8L6v+qAuCe+4CcVA7/AeXLkQD
         56pPfOfsYvPyHVAOhOhB9R8/e1xR3x8opabW98nAJWwjaI4NYZVCLS9fOcFuJzoMRRH+
         7kdTV+3lqRvYrKU9sJ4p45iHlmeKtrXK3l91dLk68KYPjjhaDXpCABLPrsyK/9fEwmlE
         Z51w==
X-Gm-Message-State: APjAAAUjrSKxXIvs7wh2FJNT/RQwnuVsD+c19NSELq8JlzOW1ShVnnLL
        4LezievlZwOxH3NFZ0jCf55eifffV2iRhX8T5av8BxL/3Xb1qZmtWT1GA5JJd7p7meKAJJzEYdY
        yMRM49Rmzq6bPsiX5tTAQpImB
X-Received: by 2002:adf:e301:: with SMTP id b1mr43578211wrj.280.1574884361880;
        Wed, 27 Nov 2019 11:52:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqwsv9XtEO7rpruY9ZcJkRC6TjBlCtMvfsdFKxhHQuULD11A6Ui5Ejf2GFuEyNIh84JMt72E/Q==
X-Received: by 2002:adf:e301:: with SMTP id b1mr43578199wrj.280.1574884361733;
        Wed, 27 Nov 2019 11:52:41 -0800 (PST)
Received: from [192.168.3.122] (p5B0C6355.dip0.t-ipconnect.de. [91.12.99.85])
        by smtp.gmail.com with ESMTPSA id l26sm7995576wmj.48.2019.11.27.11.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 11:52:41 -0800 (PST)
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1] mm/memory_hotplug: don't check the nid in find_(smallest|biggest)_section_pfn
Date:   Wed, 27 Nov 2019 20:52:40 +0100
Message-Id: <7D8F1E5C-5A39-4C76-AD2F-4D0954DB57F5@redhat.com>
References: <CE5C4BD6-FAA6-4439-B869-679D24C17298@lca.pw>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
In-Reply-To: <CE5C4BD6-FAA6-4439-B869-679D24C17298@lca.pw>
To:     Qian Cai <cai@lca.pw>
X-Mailer: iPhone Mail (17A878)
X-MC-Unique: sNM1L5unPcmyRmOhb03aWA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 27.11.2019 um 20:37 schrieb Qian Cai <cai@lca.pw>:
>=20
> =EF=BB=BF
>=20
>> On Nov 27, 2019, at 2:06 PM, David Hildenbrand <david@redhat.com> wrote:
>>=20
>> The zone pointer is unique for every node. (in contrast to the zone inde=
x).
>=20
> I am not sure if it is worth optimizing there. The existing nid check loo=
ks quite straight-forward and cheap.

I understand but strongly dislike your attitude towards code changes ;)

>=20

