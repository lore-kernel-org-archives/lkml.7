Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B595C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A6C2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfCKIeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:34:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:37642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725839AbfCKIeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:34:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0B78CAE30;
        Mon, 11 Mar 2019 08:34:20 +0000 (UTC)
Date:   Mon, 11 Mar 2019 09:34:17 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] selftests/ima: kexec_file_load syscall test
Message-ID: <20190311083417.GA13067@x230>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
 <1551223620-11586-5-git-send-email-zohar@linux.ibm.com>
 <20190228220039.GC20335@dell5510>
 <1552240104.5062.10.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1552240104.5062.10.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

> On Thu, 2019-02-28 at 23:00 +0100, Petr Vorel wrote:

> > > +	local keypair1="$2"
> > > +	local keypair2="$3"
> > > +
> > > +	mount_securityfs
> > > +
> > > +	local ima_policy=$SECURITYFS/ima/policy
> > > +	if [ ! -e $ima_policy ]; then
> > > +		log_fail "$ima_policy not found"
> > > +	fi
> > > +
> > > +	if [ -n $keypair2 ]; then
> > > +		grep -e "^$action.*$keypair1" "$ima_policy" | \
> > > +			grep -q -e "$keypair2"
> > > +	else
> > > +		grep -q -e "^$action.*$keypair1" "$ima_policy"
> > > +	fi
> > > +
> > > +	[ $? -eq 0 ] && ret=1 || ret=0
> > > +        return $ret
> > return $? is enough here (+ ret was not defined as local and mixing tabs with spaces)

> "grep -q" exits with zero if any match is found.  This line inverts
> the result so that 1 is returned for found.
Right. Sorry for wrong report :).
>  v3 will make "ret" local and fix the tabs/spaces.

> Mimi


Kind regards,
Petr
