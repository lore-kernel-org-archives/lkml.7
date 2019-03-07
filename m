Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1252C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AD620840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOdOFX7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCGSvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:51:50 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46902 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfCGSvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:51:49 -0500
Received: by mail-qk1-f195.google.com with SMTP id i5so9655381qkd.13;
        Thu, 07 Mar 2019 10:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x2omEGC/gv+4G7Hb+8y4ulQzfopNnalnjzivkJEZ9J8=;
        b=lOdOFX7r7D6zehRSnghz1hrFo3wCCxSNPYDw5ocu0oWTbcT9uVk4mNhRJJwBEJ1bh7
         c4kiXRMh4jPZmcIgg/x6sLyfFhnURhsbdYpybW/q0K9F0F5J5m+YZQmMaUfWgzjGo2aL
         k9+2YuuP/O5S9Yn2ox+5N4jWBYRhPa9/YY+9x6qggJYEjv8smkmeqMRrXzcj5ez4nmAk
         wLZKWGm35+iM2Ewl5GOMxp0L9ur4FEEZEUQyiffrhUqr3ZHGPlkHrfzshESCQ0UzhHsc
         /J5vUdME5VlycVPvVAuGoQooWjPKqOMFt73mlt4Q8v0pjJhl9wqHjHDeDSha5XRXlxI6
         TsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x2omEGC/gv+4G7Hb+8y4ulQzfopNnalnjzivkJEZ9J8=;
        b=Dzzvrt8h9kzLNrkPloS6aMHXSaPuNmgR8GUS/a3ADl10YKWu9DVSrIJQCoIxW/r7KY
         xWuozuX12u12dt0j1pvKE/tCuM89AgwExa3WKiIzU5ZVn9+Dc9l5meX2k2IZ2TdnVu7g
         cLZY/BTZdptK1KaFqyRigkR1kmrcYpFgQLH/HNKyu7jlCVAImvJQY7/jdjWdnvHJ5yki
         K7rsoGxKqiNQigKcHLRa7X1pBRS/QjOLWF5RggAWyBpToESTw2eKnJ5zHvGrMGZEi5Al
         A+KotMht0RYTbe9sBKwE53E+rOfvHkdYe/rLptFJKP+V0hnC1882On0zgbmzOcYkGT6p
         PW4w==
X-Gm-Message-State: APjAAAWsCpP1fkRNqN1sATH28O7y3o8a1t4B/5R8/bl33tC887W/pOR3
        iPnuuwMf5PedWqedmjAVMBc8Xq+6
X-Google-Smtp-Source: APXvYqyaarlxvL1bfY2jZZf8DoSxCiGAYr6l5t6qbNG6vr8UXy0LtQvcC6strHWxdQNZwvy0jSunyQ==
X-Received: by 2002:a37:aa86:: with SMTP id t128mr10798849qke.205.1551984708091;
        Thu, 07 Mar 2019 10:51:48 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id n78sm3131273qkn.10.2019.03.07.10.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 10:51:47 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CCD9D4039C; Thu,  7 Mar 2019 15:51:42 -0300 (-03)
Date:   Thu, 7 Mar 2019 15:51:42 -0300
To:     Tony Jones <tonyj@suse.de>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 6/7] perf script python: add Python3 support to sql
 scripts
Message-ID: <20190307185142.GA32240@kernel.org>
References: <20190302011903.2416-1-tonyj@suse.de>
 <20190302011903.2416-7-tonyj@suse.de>
 <7353b42e-ea14-e044-adfe-5a9705bf030c@intel.com>
 <72ea2e3d-1b82-549e-741f-d2b532e4c33b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72ea2e3d-1b82-549e-741f-d2b532e4c33b@suse.de>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 06, 2019 at 08:32:42AM -0800, Tony Jones escreveu:
> On 3/6/19 1:26 AM, Adrian Hunter wrote:
> > On 2/03/19 3:19 AM, Tony Jones wrote:
> >> Support both Python2 and Python3 in the exported-sql-viewer.py,
> >> export-to-postgresql.py and export-to-sqlite.py scripts
> >>
> >> There may be differences in the ordering of output lines due to
> >> differences in dictionary ordering etc.  However the format within lines
> >> should be unchanged.
> >>
> >> The use of 'from __future__' implies the minimum supported Python2 version
> >> is now v2.6
> >>
> >> Signed-off-by: Tony Jones <tonyj@suse.de>
> >> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> >> Cc: Adrian Hunter <adrian.hunter@intel.com>
> > 
> > Apart from one issue (see below), it looks good, thank you!
> > 
> >> ---
> >>  tools/perf/scripts/python/export-to-postgresql.py | 65 +++++++++++++++--------
> >>  tools/perf/scripts/python/export-to-sqlite.py     | 23 ++++----
> >>  tools/perf/scripts/python/exported-sql-viewer.py  | 42 ++++++++++-----
> >>  3 files changed, 84 insertions(+), 46 deletions(-)
> >>
> >> diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
> >> index 390a351d15ea..439bbbf1e036 100644
> >> --- a/tools/perf/scripts/python/export-to-postgresql.py
> >> +++ b/tools/perf/scripts/python/export-to-postgresql.py
> >> @@ -10,6 +10,8 @@
> >>  # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> >>  # more details.
> >>  
> >> +from __future__ import print_function
> >> +
> >>  import os
> >>  import sys
> >>  import struct
> >> @@ -199,6 +201,16 @@ import datetime
> >>  
> >>  from PySide.QtSql import *
> >>  
> >> +if sys.version_info < (3, 0):
> >> +	def tobytes(str):
> >> +		return str
> >> +else:
> >> +	def tobytes(str):
> >> +		# Use latin-1 (ISO-8859-1) so all code-points 0-255 will result
> >> +		# in one byte (note utf-8 is 2 bytes for values > 128 and
> >> +		# ascii is limited to values <= 128)
> >> +		return bytes(str, "ISO-8859-1")
> > 
> > Probably this should be the server_encoding, but python2 allowed UTF-8
> > so let's just use UTF-8 for now.  That will also mean doing the conversion
> > before getting the len(), otherwise len() can be wrong.
> 
> I'm not totally understanding what you're saying here.  The rationale for 
> using latin-1 and not UTF-8 was clearly expressed in the comment.  Else you 
> do indeed run into length issues.
> 
> Would it be easier, since you have a) more familiarity with the code b) some
> specific issues I'm not fully understanding if you just took this patch and
> made the changes you want yourself.  I doubt I'll ever use these scripta, my
> interest is purely in eliminating Python2 as a fixed requirement.

Adrian, can you please reply here? I'm not familiar with this tobytes()
python2/python3 difference, what do you mean about using
'server_encoding'? Where is that defined?

- Arnaldo
