Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D73BC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61851218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfGYVNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:13:05 -0400
Received: from ms.lwn.net ([45.79.88.28]:45052 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfGYVNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:13:04 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6DEB8867;
        Thu, 25 Jul 2019 21:13:03 +0000 (UTC)
Date:   Thu, 25 Jul 2019 15:13:02 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, security@kernel.org,
        linux-doc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jkosina@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH] Documentation/admin-guide: Embargoed hardware security
 issues
Message-ID: <20190725151302.16a3e0e3@lwn.net>
In-Reply-To: <20190725130113.GA12932@kroah.com>
References: <20190725130113.GA12932@kroah.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2019 15:01:13 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> To address the requirements of embargoed hardware issues, like Meltdown,
> Spectre, L1TF, etc. it is necessary to define and document a process for
> handling embargoed hardware security issues.
> 
> Following the discussion at the maintainer summit 2018 in Edinburgh
> (https://lwn.net/Articles/769417/) the volunteered people have worked
> out a process and a Memorandum of Understanding.  The latter addresses
> the fact that the Linux kernel community cannot sign NDAs for various
> reasons.
> 

[...]

>  Documentation/admin-guide/embargoed-hardware-issues.rst |  281 ++++++++++++++++
>  Documentation/admin-guide/index.rst                     |    1 
>  2 files changed, 282 insertions(+)

So I would argue that the admin guide (which is aimed at sysadmins) is the
wrong place for this document.  It's process information and is best placed
in the process manual (Documentation/process) IMO.  (Yes, I know
security-bugs.rst is in the admin guide; I remember there was a discussion
at the time and it ended up there, but I'm not really sure that's right
either).

> Note, this document has gone through numerous reviews by a number of
> kernel developers, developers at some of the Linux distros, as well as
> all of the lawyers from almost all open source-related companies.  It's
> been sitting on my local drive with no comments for a few months now,
> and it's about time to get this out and merged properly.
> 
> If anyone has any final comments, please let me know.

I do think it could benefit from a pass for basic language issues; I can do
that if such an effort would be welcome.

> If anyone from any company listed below wishes to add their name to the
> document, please send a follow-on patch and I will be glad to add it to
> the series.  I had a number of "I'll sign up" type comments from
> different people, but I want something with a "s-o-b" to keep people on
> the hook for this, so I did not add their name to the file without that.
> 
> thanks,
> 
> greg k-h
> 
> 
> 
> --- /dev/null
> +++ b/Documentation/admin-guide/embargoed-hardware-issues.rst
> @@ -0,0 +1,281 @@
> +.. _embargoedhardwareissues:

This label isn't used anywhere.

> +Embargoed hardware issues
> +=========================
> +
> +Scope
> +-----
> +
> +Hardware issues which result in security problems are a different category
> +of security bugs than pure software bugs which  only affect the Linux
> +kernel.
> +
> +Hardware issues like Meltdown, Spectre, L1TF etc. must be treated
> +differently because they usually affect all Operating Systems (“OS“) and

Somebody may well complain about the "smart quotes" here; non-ascii stuff
has led to unhappiness in the past.

> +therefore need coordination across different OS vendors, distributions,
> +hardware vendors and other parties. For some of the issues, software
> +mitigations can depend on microcode or firmware updates, which need further
> +coordination.
> +
> +.. _Contact:
> +
> +Contact
> +-------
> +
> +The Linux kernel hardware security team is separate from the regular Linux
> +kernel security team.
> +
> +The team is only handling the coordination of embargoed hardware security

s/is only handling/only handles/

> +issues. Reports of pure software security bugs in the Linux kernel are not
> +handled by this team and the reporter will be guided to contact the regular
> +Linux kernel security team (:ref:`Documentation/admin-guide/
> +<securitybugs>`) instead.
> +
> +The team can be contacted by email at <hardware-security@kernel.org>. This
> +is a private list of security officers who will help you to coordinate an
> +issue according to our documented process.
> +
> +The list is encrypted and email to the list can be sent by either PGP or
> +S/MIME encrypted and must be signed with the reporter's PGP key or S/MIME
> +certificate. The list's PGP key and S/MIME certificate are available from
> +https://www.kernel.org/....

Somebody needs to fill in some dots there...:)

> +While hardware security issues are often handled by the affected hardware
> +vendor, we welcome contact from researchers or individuals who identified a

who *have* identified

> +potential hardware flaw.
> +
> +Hardware security officers
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The current team of hardware security officers:
> +
> +  - Linus Torvalds (Linux Foundation Fellow)
> +  - Greg Kroah-Hartman (Linux Foundation Fellow)
> +  - Thomas Gleixner (Linux Foundation Fellow)
> +
> +Operation of mailing-lists
> +^^^^^^^^^^^^^^^^^^^^^^^^^^

I would de-hyphenate "mailing list" throughout.  But that's me.

> +The encrypted mailing-lists which are used in our process are hosted on
> +Linux Foundation's IT infrastructure. By providing this service Linux
> +Foundation's director of IT Infrastructure security technically has the
> +ability to access the embargoed information, but is obliged to
> +confidentiality by his employment contract. Linux Foundation's director of
> +IT Infrastructure security is also responsible for the kernel.org
> +infrastructure.
> +
> +The Linux Foundation's current director of IT Infrastructure security is
> +Konstantin Ryabitsev.
> +
> +
> +Non-disclosure agreements
> +-------------------------
> +
> +The Linux kernel hardware security team is not a formal body and therefore
> +unable to enter into any non-disclosure agreements.  The kernel community
> +is aware of the sensitive nature of such issues and offers a Memorandum of
> +Understanding instead.
> +
> +
> +Memorandum of Understanding
> +---------------------------
> +
> +The Linux kernel community has a deep understanding of the requirement to
> +keep hardware security issues under embargo for coordination between
> +different OS vendors, distributors, hardware vendors and other parties.
> +
> +The Linux kernel community has successfully handled hardware security
> +issues in the past and has the necessary mechanisms in place to allow
> +community compliant development under embargo restrictions.
> +
> +The Linux kernel community has a dedicated hardware security team for
> +initial contact, which oversees the process of handling such issues under
> +embargo rules.
> +
> +The hardware security team identifies the developers (domain experts) which
> +form the initial response team for a particular issue. The initial response

s/which form/who will form/

> +team can bring in further developers (domain experts) to address the issue
> +in the best technical way.

Does the reporter get any say in who can be in this group?  That should
probably be made explicit either way.

> +All involved developers pledge to adhere to the embargo rules and to keep
> +the received information confidential. Violation of the pledge will lead to
> +immediate exclusion from the current issue and removal from all related
> +mailing-lists. In addition, the hardware security team will also exclude
> +the offender from future issues. The impact of this consequence is a highly
> +effective deterrent in our community. In case a violation happens the
> +hardware security team will inform the involved parties immediately. If you
> +or anyone becomes aware of a potential violation, please report it
> +immediately to the Hardware security officers.
> +
> +
> +Process
> +^^^^^^^
> +
> +Due to the globally distributed nature of Linux kernel development, face to
> +face meetings are almost impossible to address hardware security issues.

face-to-face

> +Phone conferences are hard to coordinate due to time zones and other
> +factors and should be only used when absolutely necessary. Encrypted email
> +has been proven to be the most effective and secure communication method
> +for these types of issues.
> +
> +Start of Disclosure
> +"""""""""""""""""""
> +
> +Disclosure starts by contacting the Linux kernel hardware security team by
> +email. This initial contact should contain a description of the problem and
> +a list of any known affected hardware. If your organization builds or
> +distributes the affected hardware, we encourage you to also consider what
> +other hardware could be affected.
> +
> +The hardware security team will provide a per incident specific encrypted

s/per incident specific/incident-specific/

> +mailing-list which will be used for initial discussion with the reporter,
> +further disclosure and coordination.
> +
> +The hardware security team will provide the disclosing party a list of
> +developers (domain experts) who should be informed initially about the
> +issue after confirming with the developers  that they will adhere to this
> +Memorandum of Understanding and the documented process. These developers
> +form the initial response team and will be responsible for handling the
> +issue after initial contact. The hardware security team is supporting the
> +response team, but is not necessarily involved in the mitigation
> +development process.

Again, "should be informed" is conditional, suggesting that the reporter
might have some sort of veto power.  But the actual policy is not clear.

> +While individual developers might be covered by a non-disclosure agreement
> +via their employer, they cannot enter individual non-disclosure agreements
> +in their role as Linux kernel developers. They will, however, adhere to
> +this documented process and the Memorandum of Understanding.

They will *agree to* adhere ...  We expect that actual adherence will be
the case but there is no way (even if an NDA were involved) to guarantee
that.

> +Disclosure
> +""""""""""
> +
> +The disclosing party provides detailed information to the initial response
> +team via the specific encrypted mailing-list.
> +
> +From our experience the technical documentation of these issues is usually
> +a sufficient starting point and further technical clarification is best
> +done via email.
> +
> +Mitigation development
> +""""""""""""""""""""""
> +
> +The initial response team sets up an encrypted mailing-list or repurposes
> +an existing one if appropriate. The disclosing party should provide a list
> +of contacts for all other parties who have already been, or should be
> +informed about the issue. The response team contacts these parties so they
> +can name experts who should be subscribed to the mailing-list.
> +
> +Using a mailing-list is close to the normal Linux development process and
> +has been successfully used in developing mitigations for various hardware
> +security issues in the past.
> +
> +The mailing-list operates in the same way as normal Linux development.
> +Patches are posted, discussed and reviewed and if agreed on applied to a
> +non-public git repository which is only accessible to the participating
> +developers via a secure connection. The repository contains the main
> +development branch against the mainline kernel and backport branches for
> +stable kernel versions as necessary.

Do we want to envision a KPTI-like situation where the mitigation can be
developed publicly?  Or perhaps just handle any such case if and when it
ever arises?

> +The initial response team will identify further experts from the Linux
> +kernel developer community as needed and inform the disclosing party about
> +their participation. Bringing in experts can happen at any time of the
> +development process and often needs to be handled in a timely manner.
> +
> +Coordinated release
> +"""""""""""""""""""
> +
> +The involved parties will negotiate the date and time where the embargo
> +ends. At that point the prepared mitigations are integrated into the
> +relevant kernel trees and published.
> +
> +While we understand that hardware security issues need coordinated embargo
> +time, the embargo time should be constrained to the minimum time which is
> +required for all involved parties to develop, test and prepare the
> +mitigations. Extending embargo time artificially to meet conference talk
> +dates or other non-technical reasons is creating more work and burden for
> +the involved developers and response teams as the patches need to be kept
> +up to date in order to follow the ongoing upstream kernel development,
> +which might create conflicting changes.
> +
> +CVE assignment
> +""""""""""""""
> +
> +Neither the hardware security team nor the initial response team assign
> +CVEs, nor are CVEs required for the development process. If CVEs are
> +provided by the disclosing party they can be used for documentation
> +purposes.
> +
> +Process ambassadors
> +-------------------
> +
> +For assistance with this process we have established ambassadors in various
> +organizations, who can answer questions about or provide guidance on the
> +reporting process and further handling. Ambassadors are not involved in the
> +disclosure of a particular issue, unless requested by a response team or by
> +an involved disclosed party. The current ambassadors list:
> +
> +  ============== ========================================================
> +  ARM
> +  AMD
> +  IBM
> +  Intel
> +  Qualcomm
> +
> +  Microsoft
> +  VMware
> +  XEN
> +
> +  Canonical
> +  Debian
> +  Oracle
> +  Redhat
> +  Suse           Jiri Kosina <jkosina@suse.com>
> +
> +  Amazon
> +  Google
> +  ============== ========================================================

Having companies without names seems a little weird.  Unless perhaps you
have people teed up to add their names in follow-on patches?

> +If you want your organization to be added to the ambassadors list, please
> +contact the hardware security team. The nominated ambassador has to
> +understand and support our process fully and is ideally well connected in
> +the Linux kernel community.
> +
> +Encrypted mailing-lists
> +-----------------------
> +
> +We use encrypted mailing-lists for communication. The operating principle
> +of these lists is that email sent to the list is encrypted either with the
> +list's PGP key or with the list's S/MIME certificate. The mailing-list
> +software decrypts the email and re-encrypts it individually for each
> +subscriber with the subscriber's PGP key or S/MIME certificate. Details
> +about the mailing-list software and the setup which is used to ensure the
> +security of the lists and protection of the data can be found here:
> +https://www.kernel.org/....

That URL is also in need of completion.

The topic of encrypted mailing lists is visited several times in this
document; I wonder if that could be coalesced somehow?

> +List keys
> +^^^^^^^^^
> +
> +For initial contact see :ref:`Contact`. For incident specific mailing-lists
> +the key and S/MIME certificate are conveyed to the subscribers by email
> +sent from the specific list.
> +
> +Subscription to incident specific lists
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Subscription is handled by the response teams. Disclosed parties who want
> +to participate in the communication send a list of potential subscribers to
> +the response team so the response team can validate subscription requests.
> +
> +Each subscriber needs to send a subscription request to the response team
> +by email. The email must be signed with the subscriber's PGP key or S/MIME
> +certificate. If a PGP key is used, it must be available from a public key
> +server and is ideally connected to the Linux kernel's PGP web of trust. See
> +also: https://www.kernel.org/signature.html.

The "public key server" thing isn't working quite as well as it was; does
this requirement need to be revisited?

> +The response team verifies that the subscriber request is valid and adds
> +the subscriber to the list. After subscription the subscriber will receive
> +email from the mailing-list which is signed either with the list's PGP key
> +or the list's S/MIME certificate. The subscriber's email client can extract
> +the PGP key or the S/MIME certificate from the signature so the subscriber
> +can send encrypted email to the list.
> +
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -33,6 +33,7 @@ problems and bugs in particular.
>  
>     reporting-bugs
>     security-bugs
> +   embargoed-hardware-issues
>     bug-hunting
>     bug-bisect
>     tainted-kernels

jon
