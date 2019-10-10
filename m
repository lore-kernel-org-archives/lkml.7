Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDC4ECE58C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03952086D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EhPM9H9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732221AbfJJAW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 20:22:56 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43827 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731553AbfJJAW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 20:22:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46pWy251BKz9s7T;
        Thu, 10 Oct 2019 11:22:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1570666973;
        bh=7+fjtYqa172Ftzt3UBW5VOoZd1S9i31z/HZVdVxdAZ0=;
        h=Date:From:To:Cc:Subject:From;
        b=EhPM9H9Cwzep0HCSliuIfx+P2uR+uy6coKqispWQSTVxbJW5kvWl81W0ZL5R19dT4
         TLfMrbeITvv0MkitjTxaA/tb+y2u59dmaZ/eRaa3rdZ6ODWDrH9jq9Eu2WpXFYfPXO
         Pet0clnSfsaiLvL0Calao53LlLEffJeLTny6B69ZbWb2rO6hTw7JEOJnHQYM092iFL
         NggyZaab0LLrn/6Y0688JJBf3MlBMcHXz+uN1DcQCZ2Ii3+QoDhqGOGRRP6IOqezxy
         U//FxX5Z+0N7hC219Z5py2S2/AoaGbxukj23BDrv1RiwKJFhb1ebdOAN59w/pb5xjQ
         hECYVDcP6oLwQ==
Date:   Thu, 10 Oct 2019 11:22:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: linux-next: build failure after merge of the drm tree
Message-ID: <20191010112249.720989aa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lIT/TpjrrNf6nF9Pwa/PMRX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lIT/TpjrrNf6nF9Pwa/PMRX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

In file included from drivers/gpu/drm/i915/i915_vma.h:35,
                 from drivers/gpu/drm/i915/gt/uc/intel_guc.h:17,
                 from drivers/gpu/drm/i915/gt/uc/intel_uc.h:9,
                 from drivers/gpu/drm/i915/gt/intel_gt_types.h:16,
                 from drivers/gpu/drm/i915/i915_drv.h:81,
                 from drivers/gpu/drm/i915/i915_getparam.c:7:
drivers/gpu/drm/i915/gem/i915_gem_object.h:174:1: error: redefinition of 'i=
915_gem_object_never_bind_ggtt'
  174 | i915_gem_object_never_bind_ggtt(const struct drm_i915_gem_object *o=
bj)
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/gem/i915_gem_object.h:168:1: note: previous definition=
 of 'i915_gem_object_never_bind_ggtt' was here
  168 | i915_gem_object_never_bind_ggtt(const struct drm_i915_gem_object *o=
bj)
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by the automatic merge of commit

  3a1fea6d2353 ("drm/i915/userptr: Never allow userptr into the mappable GG=
TT")

from the drm-intel-fixes tree and commits

  a4311745bba9 ("drm/i915/userptr: Never allow userptr into the mappable GG=
TT")
  3cbad5d77749 ("drm/i915/gem: Refactor tests on obj->ops->flags")

from the drm tree.

I fixed it up by removing the extra definition.  This sort of thing will
keep happening as longs as bugs are fixed in your development trees
and then cherry-picked back into your -fixes trees.  This practise also
causes quite a few unnecessary conflicts that each have to be checked
and merged by hand.

--=20
Cheers,
Stephen Rothwell

--Sig_/lIT/TpjrrNf6nF9Pwa/PMRX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2eedkACgkQAVBC80lX
0GyOYgf/f4qvlGy3OVWVxHDAOJjjxnAAWRG3u5oxfmagSZsi3NjqV9aGPzQXJk0P
YoPfZv35qqfSSTB3Ao9XTUbij2nI5/76mq7oPp/0/43MLyeun+/pPQlyZ4sPp7qi
eddvMCPvRfF6PjH2R12zeopTsT6HtXp5Gfo2E+tLxGrxjWEKQbq8HZFsZEnN3sZx
T88Nu7zJ4grx8043pf8ZqVAMTQmKkaNHtZC33ZPNKsiFSt2UzyNxiD8ukKnkm1st
6iVAcfe3Mw/ZVWIQHt2z8KWMPrBzhZo7LXoJtD2bem1LlP0bLC9E4WmQWIjzvWcu
IfMKQdFmfnpWffH5pe/C5OPucH10ng==
=3MwN
-----END PGP SIGNATURE-----

--Sig_/lIT/TpjrrNf6nF9Pwa/PMRX--
