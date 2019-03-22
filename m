Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B354C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442572070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390555AbfCVMSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:18:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:38966 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390153AbfCVMSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:18:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56ED2AB91;
        Fri, 22 Mar 2019 12:18:44 +0000 (UTC)
Date:   Fri, 22 Mar 2019 13:18:42 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     djacobs7@binghamton.edu
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, vt@altlinux.org
Subject: Re: [PATCH v2 1/8] evmtest: Regression testing integrity subsystem
Message-ID: <20190322121842.GA32091@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190322083441.31084-1-djacobs7@binghamton.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322083441.31084-1-djacobs7@binghamton.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> $ evmtest runtest example_test -e /bin/bash
> [*] Starting test: example_test
> [*] TEST: PASSED

> Example 1a: successful verbose example test output
> $ evmtest runtest example_test -e /bin/bash -v
...

> Changelog:
...
> * checkbashishms compliant
Not yet :). I noticed using
source (should be .)
== (should be =)
${BASH_SOURCE[0]} (should be $0)
$UID (should be $(id -u)
bash redirection &>> (should be >/dev/null 2>&1)
+= (should be VAR="${VAR}foo")
and bash shebang.

Could you please fix that?

...
> +++ b/evmtest/evmtest
> @@ -0,0 +1,67 @@
> +#!/bin/bash

Can we, please, use /bin/sh and not-expect bash?
Portability matters.

> +source "$EVMDIR"/files/common.sh
> +usage (){
> +	echo "Usage:"
> +	echo "	evmtest runtest <test name> [OPTIONS]"
> +	echo ""
Can be just echo. Maybe using cat might be better than many echos:

cat <<EOF
Usage:
\tevmtest runtest <test name> [OPTIONS]
...
EOF


Kind regards,
Petr
