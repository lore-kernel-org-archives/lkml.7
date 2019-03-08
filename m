Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08036C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CB52081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o/xisGLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfCHWsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:48:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59282 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCHWsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 17:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1r17wNeVd7QuipWdYqmezBM4/scLlFX8lZfVjNw355g=; b=o/xisGLzZ+O7+D6rpPFdrPvuN
        xzA84fRftn62JkuVZNif1cs7oWZYfOmorutEgYVoe631GvmdrB947Da+wdTbQg+2SZmyGgJgrMvQG
        MAMMYjxNbZMUkKcIEeq1p+1WBadMUDPIfQzRDUqcMcPQPXsybiJ+kAXw+QV6Njj+Q3hjv1esgTLRR
        6HvnbooheMh8rJLQzHBqDgoBXJPoti3XjKHKsu8187fSlp60RPcg/szM9DUdyswGZNLZHZIcdrhap
        ldabn7OU3QrWoM9hvFWcdhEl4Y6Dlv/Z24mNswX4m99ZQH/TFqAP8DZwr875cDnar5l/o0psUVeTr
        Fp5EKcJdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2OHy-0001B6-1y; Fri, 08 Mar 2019 22:48:26 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE4A6981BBE; Fri,  8 Mar 2019 23:48:22 +0100 (CET)
Date:   Fri, 8 Mar 2019 23:48:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] x86/percpu semantics and fixes
Message-ID: <20190308224822.GG2482@worktop.programming.kicks-ass.net>
References: <20190227101252.413192716@infradead.org>
 <20190308145031.GY32494@hirez.programming.kicks-ass.net>
 <64526663-1F10-42A6-A005-92657264D587@vmware.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <64526663-1F10-42A6-A005-92657264D587@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 08, 2019 at 07:35:17PM +0000, Nadav Amit wrote:
> Nice script!

Find a new one; this one is fast enough to run a symbol diff on vmlinux.o


--ikeVEW9yuYc//A+q
Content-Type: application/x-sh
Content-Disposition: attachment; filename="compare.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A=0Asrc=3D$1; shift=0Adst=3D$1; shift=0Aobj=3D$1; shift=0Asym=
=3D$1; shift=0A=0Aif [ -n "$sym" ] ; then=0A=0A	readarray A < <(objdump -dr=
 $src/$obj | awk "/>:\$/ { P=3D0; } /$sym(.cold.[[:digit:]]*)*>:\$/ { P=3D1=
; O=3Dstrtonum(\"0x\" \$1); } { if (P) { o=3Dstrtonum(\"0x\" \$1); printf(\=
"%04x \", o-O); print \$0; } }");=0A	readarray B < <(objdump -dr $dst/$obj =
| awk "/>:\$/ { P=3D0; } /$sym(.cold.[[:digit:]]*)*>:\$/ { P=3D1; O=3Dstrto=
num(\"0x\" \$1); } { if (P) { o=3Dstrtonum(\"0x\" \$1); printf(\"%04x \", o=
-O); print \$0; } }");=0A=0A	for ((i=3D0; i<${#A[*]} || i<${#B[*]}; i++));=
=0A	do=0A		if [ "${A[$i]}" =3D "${B[$i]}" ] ; then=0A			sep=3D"|"=0A		else=
=0A			sep=3D"\\"=0A		fi=0A		printf "%-80.80s%c%s %-80.80s\n" "${A[$i]%%[[:s=
pace:]]}" $'\x1d' $sep "${B[$i]%%[[:space:]]}" ;=0A=0A	done | column -t -s$=
'\x1d'=0A	exit;=0Afi=0A=0Aif [ -n "$obj" ] ; then=0A=0A	declare -A Sa;=0A	d=
eclare -A Sb;=0A	let n=3D0;=0A=0A	while read sym size; do=0A	    S[$n]=3D$s=
ym;=0A	    Sa[$sym]=3D$size;=0A	    let n=3Dn+1;=0A	done < <( readelf -Ws $=
src/$obj | grep -v -e "\.cold\." -e "OBJECT" | awk '/DEFAULT/ { if ($3 > 0)=
 { print $8 " " $3} }' );=0A=0A	while read sym size; do=0A	    Sb[$sym]=3D$=
size;=0A	    if [ -z "${Sa[$sym]}" ] ; then=0A	        S[$n]=3D$sym;=0A	   =
     let n=3Dn+1;=0A	    fi;=0A	done < <( readelf -Ws $dst/$obj | grep -v -=
e "\.cold\." -e "OBJECT" | awk '/DEFAULT/ { if ($3 > 0) { print $8 " " $3} =
}' );=0A=0A	for ((i=3D0; i<$n; i++)) ; do=0A		sym=3D${S[$i]};=0A		sa=3D${Sa=
[$sym]}=0A		if [ -z "$sa" ] ; then sa=3D0; fi=0A		sb=3D${Sb[$sym]}=0A		if [=
 -z "$sb" ] ; then sb=3D0; fi=0A=0A		if [ "$sa" -ne "$sb" ] ; then=0A			pri=
ntf "%-50s %10d %10d   %+d\n" $sym $sa $sb $(($sb-$sa));=0A		fi=0A	done;=0A=
=0A	exit;=0Afi=0A=0Afind ${src}/ -name \*.o | grep -v -e piggy\.o -e \.tmp_=
 -e vmlinux\.o | ( while read file ;=0Ado=0A	file=3D${file#${src}/};=0A	s1=
=3D$(readelf -WS $src/$file | grep "AX" | awk '{ s+=3Dstrtonum("0x"$6) } EN=
D { print s }');=0A	if [ -z "$s1" ]; then s1=3D0; fi=0A	s2=3D$(readelf -WS =
$dst/$file | grep "AX" | awk '{ s+=3Dstrtonum("0x"$6) } END { print s }');=
=0A	if [ -z "$s2" ]; then s2=3D0; fi=0A	let S1+=3Ds1;=0A	let S2+=3Ds2;=0A	i=
f [ "$s1" -ne "$s2" ] ;=0A	then=0A		diff=3D$(($s2-$s1));=0A		let D+=3Ddiff;=
=0A		printf "%-50s %10d %10d   %+d\n" $file $s1 $s2 $diff;=0A	fi;=0Adone ; =
printf "%50s %10d %10d   %+d\n" "total" $S1 $S2 $D )=0A=0A
--ikeVEW9yuYc//A+q--
