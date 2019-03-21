Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60E2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FC02183E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="e/ayiVzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfCUU2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:28:38 -0400
Received: from ozlabs.org ([203.11.71.1]:60363 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbfCUU2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:28:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44QJJw3B5Bz9sRH;
        Fri, 22 Mar 2019 07:28:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553200112;
        bh=VrbZYNqI4t58SScirXpoUroseC0rszAkmOrpW0qnnUc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e/ayiVzjWNlQmXwhd6WMq+WlfFDKD01GrjxCHeH92eHapN1n3YHHM9uuiGL7bDlE6
         kwF2RJEeyy8nL0wCRTDT79MA4jmdmILzo3P6TWm+h6btFWTub0zMUy75MvcHHVaiQw
         gW4mjsc5sUpqztgMhHysJ4ss9Me11wzOVQaEYLsIutjqcd5lc2X5Wof6+Bi2SetUIj
         FtXRezgf90YVCbCiYbn6SrLJadx3ivo5eo76qBHyC3fjQF4Tn0ffoD20QBAumWeRCl
         Di2Omg53a8Awji8EHKDy3zaxUOfdEaY2WG1LMt7RA1e1eoZzcX6EoFS/rGK4RCZWcH
         U1v0kl74ixK3A==
Date:   Fri, 22 Mar 2019 07:28:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jon Mason <jdmason@kudzu.us>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        NTB Mailing List <linux-ntb@googlegroups.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the ntb tree
Message-ID: <20190322072829.77e6c245@canb.auug.org.au>
In-Reply-To: <CAPoiz9x9aWMzV3K-UhBz52AXdVpDbCQnLTeM7=nt5tAFL2RPBQ@mail.gmail.com>
References: <20190321075818.24f9703a@canb.auug.org.au>
        <8a8ce003-c151-d04b-3ac9-8823a6c8ff7b@deltatee.com>
        <CAPoiz9x9aWMzV3K-UhBz52AXdVpDbCQnLTeM7=nt5tAFL2RPBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ghYdUvM5giR_j_g3CS0OrNd"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ghYdUvM5giR_j_g3CS0OrNd
Content-Type: multipart/mixed; boundary="MP_/x5Pea2VCK=0_yTlO6wLnJ9y"

--MP_/x5Pea2VCK=0_yTlO6wLnJ9y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jon,

On Thu, 21 Mar 2019 15:53:47 -0400 Jon Mason <jdmason@kudzu.us> wrote:
>
> Is there an existing set of tools/scripts I should run to prevent
> things like this from happening?

I have attached the script I run over all new commits submitted for
linux-next.

--=20
Cheers,
Stephen Rothwell

--MP_/x5Pea2VCK=0_yTlO6wLnJ9y
Content-Type: application/x-shellscript
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=check_fixes

#!/bin/bash

if [ "$#" -lt 1 ]; then
        printf 'Usage: %s <commit range>\n', "$0" 1>&2
        exit 1
fi

commits=3D$(git rev-list --no-merges -i --grep=3D'^[[:space:]]*Fixes:' "$@")
if [ -z "$commits" ]; then
        exit 0
fi

# This should be a git tree that contains *only* Linus' tree
Linus_tree=3D"${HOME}/kernels/linus.git"

split_re=3D'^([Cc][Oo][Mm][Mm][Ii][Tt])?[[:space:]]*([[:xdigit:]]{5,})([[:s=
pace:]]*)(.*)$'
nl=3D$'\n'
tab=3D$'\t'

# Strip the leading and training spaces from a string
strip_spaces()
{
	[[ "$1" =3D~ ^[[:space:]]*(.*[^[:space:]])[[:space:]]*$ ]]
	echo "${BASH_REMATCH[1]}"
}

for c in $commits; do

	commit_log=3D$(git log -1 --format=3D'%h ("%s")' "$c")
	commit_msg=3D"In commit

  $commit_log

"

	fixes_lines=3D$(git log -1 --format=3D'%B' "$c" |
			grep -i '^[[:space:]]*Fixes:')

	while read -r fline; do
		[[ "$fline" =3D~ ^[[:space:]]*[Ff][Ii][Xx][Ee][Ss]:[[:space:]]*(.*)$ ]]
		f=3D"${BASH_REMATCH[1]}"
		fixes_msg=3D"Fixes tag

  $fline

has these problem(s):

"
		sha=3D
		subject=3D
		msg=3D
		if [[ "$f" =3D~ $split_re ]]; then
			first=3D"${BASH_REMATCH[1]}"
			sha=3D"${BASH_REMATCH[2]}"
			spaces=3D"${BASH_REMATCH[3]}"
			subject=3D"${BASH_REMATCH[4]}"
			if [ "$first" ]; then
				msg=3D"${msg:+${msg}${nl}}  - leading word '$first' unexpected"
			fi
			if [ -z "$subject" ]; then
				msg=3D"${msg:+${msg}${nl}}  - missing subject"
			elif [ -z "$spaces" ]; then
				msg=3D"${msg:+${msg}${nl}}  - missing space between the SHA1 and the su=
bject"
			fi
		else
			printf '%s%s  - %s\n' "$commit_msg" "$fixes_msg" 'No SHA1 recognised'
			commit_msg=3D''
			continue
		fi
		if ! git rev-parse -q --verify "$sha" >/dev/null; then
			printf '%s%s  - %s\n' "$commit_msg" "$fixes_msg" 'Target SHA1 does not e=
xist'
			commit_msg=3D''
			continue
		fi

		if [ "${#sha}" -lt 12 ]; then
			msg=3D"${msg:+${msg}${nl}}  - SHA1 should be at least 12 digits long${nl=
}    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11$=
{nl}    or later) just making sure it is not set (or set to \"auto\")."
		fi
		# reduce the subject to the part between () if there
		if [[ "$subject" =3D~ ^\((.*)\) ]]; then
			subject=3D"${BASH_REMATCH[1]}"
		elif [[ "$subject" =3D~ ^\((.*) ]]; then
			subject=3D"${BASH_REMATCH[1]}"
			msg=3D"${msg:+${msg}${nl}}  - Subject has leading but no trailing parent=
heses"
		fi

		# strip matching quotes at the start and end of the subject
		# the unicode characters in the classes are
		# U+201C LEFT DOUBLE QUOTATION MARK
		# U+201D RIGHT DOUBLE QUOTATION MARK
		# U+2018 LEFT SINGLE QUOTATION MARK
		# U+2019 RIGHT SINGLE QUOTATION MARK
		re1=3D$'^[\"\u201C](.*)[\"\u201D]$'
		re2=3D$'^[\'\u2018](.*)[\'\u2019]$'
		re3=3D$'^[\"\'\u201C\u2018](.*)$'
		if [[ "$subject" =3D~ $re1 ]]; then
			subject=3D"${BASH_REMATCH[1]}"
		elif [[ "$subject" =3D~ $re2 ]]; then
			subject=3D"${BASH_REMATCH[1]}"
		elif [[ "$subject" =3D~ $re3 ]]; then
			subject=3D"${BASH_REMATCH[1]}"
			msg=3D"${msg:+${msg}${nl}}  - Subject has leading but no trailing quotes"
		fi

		subject=3D$(strip_spaces "$subject")

		target_subject=3D$(git log -1 --format=3D'%s' "$sha")
		target_subject=3D$(strip_spaces "$target_subject")

		# match with ellipses
		case "$subject" in
		*...)	subject=3D"${subject%...}"
			target_subject=3D"${target_subject:0:${#subject}}"
			;;
		...*)	subject=3D"${subject#...}"
			target_subject=3D"${target_subject: -${#subject}}"
			;;
		*\ ...\ *)
			s1=3D"${subject% ... *}"
			s2=3D"${subject#* ... }"
			subject=3D"$s1 $s2"
			t1=3D"${target_subject:0:${#s1}}"
			t2=3D"${target_subject: -${#s2}}"
			target_subject=3D"$t1 $t2"
			;;
		esac
		subject=3D$(strip_spaces "$subject")
		target_subject=3D$(strip_spaces "$target_subject")

		if [ "$subject" !=3D "${target_subject:0:${#subject}}" ]; then
			msg=3D"${msg:+${msg}${nl}}  - Subject does not match target commit subje=
ct${nl}    Just use${nl}${tab}git log -1 --format=3D'Fixes: %h ("%s")'"
		fi
		lsha=3D$(cd "$Linus_tree" && git rev-parse -q --verify "$sha")
		if [ -z "$lsha" ]; then
			count=3D$(git rev-list --count "$sha".."$c")
			if [ "$count" -eq 0 ]; then
				msg=3D"${msg:+${msg}${nl}}  - Target is not an ancestor of this commit"
			fi
		fi
		if [ "$msg" ]; then
			printf '%s%s%s\n' "$commit_msg" "$fixes_msg" "$msg"
			commit_msg=3D''
		fi
	done <<< "$fixes_lines"
done

exit 0

--MP_/x5Pea2VCK=0_yTlO6wLnJ9y--

--Sig_/ghYdUvM5giR_j_g3CS0OrNd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyT8+0ACgkQAVBC80lX
0Gz2KggAjqrkZuyBoxz5mq3ijvSIlESkb2hM03ANq8vDm/4eM7bVT1F1hA3A8Qx7
losGn96TGldzgK9AcsND9XF0sIQPB9R5HdKTxDwCr8nCEb/ZuFXs7ztTmXPpWZns
zqmJAE7kTw37+4uhih4sapHkVueV1nhtAz5aEqFC9tD6bCUjnd2SewL3ojAhPvDk
5i8P+JmMCtG/wEhU9N8HrdiJqExN4ZGJsfiaAEkoZdR/JE43tgI0o9i9FrAS6lxy
KzM2RKCRXUrBMagnZ4p/Y5E9N6JYHO7+YJ1LEwAudSpc+jmnMBvMOpZ64LMTJ+lS
oTE3ZTl+DRrg66QDgiETsBPWfjZffQ==
=8yGD
-----END PGP SIGNATURE-----

--Sig_/ghYdUvM5giR_j_g3CS0OrNd--
