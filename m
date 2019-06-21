Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EF7C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EB620675
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561110560;
	bh=fpZ0npQBlIwVDm4stqfpFB3lpfOiajQlK+2e65FxgCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=U8RXVB7BiV3sxn/6L6PdxCW7n91EhS5Ejk8+0CsC8ZgwfEuDxpsyy036WobpddzTN
	 7RFCXXUDgwExHMSZGzfdhUf1zySCBeCg9250Lk6HomLs2wo2Zdbl/rEerdqFLglSz0
	 ZpeyBX7rr4/koPphSPODFbs1zmuSN6rr16rlMkFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfFUJtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:49:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfFUJtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=koZZ3EshWXmJOByQ/cJ8oNCdfEb7QFiA8UP9NCG41rk=; b=VPIok37CrK1bvZ9rQSBIu3f+H
        i507xi0SIw0bpLIh7tX6cXPw1BJ1gXyWOrSoPLCs9RwqPva/ekh+CnjW4MDF2pu29w1azthHL6sKj
        F0UF/UIwMlKfsViYb5xc8CNs02khgkBiwZiXUX6bTVMKRmLeBd7G3YHurD9uADXyR/XPn12o+cQef
        alljGjORGIcykJ2mvYiA9wgx0HnRNEfIXSk94aXwJi2+AmZ39DmF5x/+ZHywMnvurHXMGsQ1WfQ0R
        rulwBoSrK9hYp3PjjxLly9fv6jVR+4/BGolpqjdKVddNM5Rp5I+EcG7AmLfyf3pfWfwa69lBDS1pM
        rIDyfev8g==;
Received: from [177.97.20.138] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heGAT-0007Iq-5R; Fri, 21 Jun 2019 09:49:14 +0000
Date:   Fri, 21 Jun 2019 06:49:08 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: Re: [PATCH 04/14] ABI: better identificate tables
Message-ID: <20190621064908.5ee6910e@coco.lan>
In-Reply-To: <20190621072152.GA21300@kroah.com>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
        <6bc45c0d5d464d25d4d16eceac48a2f407166944.1560477540.git.mchehab+samsung@kernel.org>
        <20190619125135.GG25248@localhost>
        <20190619105633.7f7315a5@coco.lan>
        <20190619150207.GA19346@kroah.com>
        <20190619131408.26b45c3b@coco.lan>
        <20190620112749.5e3fb4e9@coco.lan>
        <20190621072152.GA21300@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 21 Jun 2019 09:21:52 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Thu, Jun 20, 2019 at 11:27:49AM -0300, Mauro Carvalho Chehab wrote:
> > Em Wed, 19 Jun 2019 13:14:08 -0300
> > Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:
> >  =20
> > > Em Wed, 19 Jun 2019 17:02:07 +0200
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> > >  =20
> > > > On Wed, Jun 19, 2019 at 10:56:33AM -0300, Mauro Carvalho Chehab wro=
te:   =20
> > > > > Hi Johan,
> > > > >=20
> > > > > Em Wed, 19 Jun 2019 14:51:35 +0200
> > > > > Johan Hovold <johan@kernel.org> escreveu:
> > > > >      =20
> > > > > > On Thu, Jun 13, 2019 at 11:04:10PM -0300, Mauro Carvalho Chehab=
 wrote:     =20
> > > > > > > From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> > > > > > >=20
> > > > > > > When parsing via script, it is important to know if the script
> > > > > > > should consider a description as a literal block that should
> > > > > > > be displayed as-is, or if the description can be considered
> > > > > > > as a normal text.
> > > > > > >=20
> > > > > > > Change descriptions to ensure that the preceding line of a ta=
ble
> > > > > > > ends with a colon. That makes easy to identify the need of a
> > > > > > > literal block.       =20
> > > > > >=20
> > > > > > In the cover letter you say that the first four patches of this=
 series,
> > > > > > including this one, "fix some ABI descriptions that are violati=
ng the
> > > > > > syntax described at Documentation/ABI/README". This seems a bit=
 harsh,
> > > > > > given that it's you that is now *introducing* a new syntax requ=
irement
> > > > > > to assist your script.     =20
> > > > >=20
> > > > > Yeah, what's there at the cover letter doesn't apply to this spec=
ific
> > > > > patch. The thing is that I wrote this series a lot of time ago (2=
016/17).
> > > > >=20
> > > > > I revived those per a request at KS ML, as we still need to expos=
e the
> > > > > ABI content on some book that will be used by userspace people.
> > > > >=20
> > > > > So, I just rebased it on the top of curent Kernel, add a cover le=
tter
> > > > > with the things I remembered and re-sent.
> > > > >=20
> > > > > In the specific case of this patch, the ":" there actually makes =
sense
> > > > > for someone that it is reading it as a text file, and it is an ea=
sy
> > > > > hack to make it parse better.
> > > > >      =20
> > > > > > Specifically, this new requirement isn't documented anywhere AF=
AICT, so
> > > > > > how will anyone adding new ABI descriptions learn about it?    =
 =20
> > > > >=20
> > > > > Yeah, either that or provide an alternative to "Description" tag,=
 to be
> > > > > used with more complex ABI descriptions.
> > > > >=20
> > > > > One of the things that occurred to me, back on 2017, is that we s=
hould
> > > > > have a way to to specify that an specific ABI description would h=
ave
> > > > > a rich format. Something like:
> > > > >=20
> > > > > What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<inter=
face num>/<hid-bus>:<vendor-id>:<product-id>.<num>/pyra/roccatpyra<minor>/a=
ctual_cpi
> > > > > Date:		August 2010
> > > > > Contact:	Stefan Achatz <erazor_de@users.sourceforge.net>
> > > > > RST-Description:
> > > > > 		It is possible to switch the cpi setting of the mouse with the
> > > > > 		press of a button.
> > > > > 		When read, this file returns the raw number of the actual cpi
> > > > > 		setting reported by the mouse. This number has to be further
> > > > > 		processed to receive the real dpi value:
> > > > >=20
> > > > > 		=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D
> > > > > 		VALUE DPI
> > > > > 		=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D
> > > > > 		1     400
> > > > > 		2     800
> > > > > 		4     1600
> > > > > 		=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D
> > > > >=20
> > > > > With that, the script will know that the description contents wil=
l be using
> > > > > the ReST markup, and parse it accordingly. Right now, what it doe=
s, instead,
> > > > > is to place the description on a code-block, e. g. it will produc=
e this
> > > > > output for the description:
> > > > >=20
> > > > > ::
> > > > >=20
> > > > > 		It is possible to switch the cpi setting of the mouse with the
> > > > > 		press of a button.
> > > > > 		When read, this file returns the raw number of the actual cpi
> > > > > 		setting reported by the mouse. This number has to be further
> > > > > 		processed to receive the real dpi value:
> > > > >=20
> > > > > 		VALUE DPI
> > > > > 		1     400
> > > > > 		2     800
> > > > > 		4     1600
> > > > >=20
> > > > >=20
> > > > > Greg,=20
> > > > >=20
> > > > > what do you think?     =20
> > > >=20
> > > > I don't know when "Description" and "RST-Description" would be used.
> > > > Why not just parse "Description" like rst text and if things are "m=
essy"
> > > > we fix them up as found, like you did with the ":" here?  It doesn't
> > > > have to be complex, we can always fix them up after-the-fact if new
> > > > stuff gets added that doesn't quite parse properly.
> > > >=20
> > > > Just like we do for most kernel-doc formatting :)   =20
> > >=20
> > > Works for me. Yet, I guess I tried that, back on 2017.=20
> > >=20
> > > If I'm not mistaken, the initial patchset to solve the broken things=
=20
> > > won't be small, and will be require a lot of attention in order to
> > > identify what's broken and where.
> > >=20
> > > Btw, one thing is to pass at ReST validation. Another thing is to
> > > produce something that people can read.=20
> > >=20
> > > Right now, the pertinent logic at the script I wrote (scripts/get_abi=
.pl)
> > > is here:
> > >=20
> > >                 if (!($desc =3D~ /^\s*$/)) {
> > >                         if ($desc =3D~ m/\:\n/ || $desc =3D~ m/\n[\t =
]+/  || $desc =3D~ m/[\x00-\x08\x0b-\x1f\x7b-\xff]/) {
> > >                                 # put everything inside a code block
> > >                                 $desc =3D~ s/\n/\n /g;
> > >=20
> > >                                 print "::\n\n";
> > >                                 print " $desc\n\n";
> > >                         } else {
> > >                                 # Escape any special chars from descr=
iption
> > >                                 $desc =3D~s/([\x00-\x08\x0b-\x1f\x21-=
\x2a\x2d\x2f\x3c-\x40\x5c\x5e-\x60\x7b-\xff])/\\$1/g;
> > >=20
> > >                                 print "$desc\n\n";
> > >                         }
> > >                 }
> > >=20
> > > If it discovers something weird enough, it just places everything
> > > into a comment block. Otherwise, it assumes that it is a plain
> > > text and that any special characters should be escaped.
> > >=20
> > > If the above block is replaced by a simple:
> > >=20
> > > 		print "$desc\n\n";
> > >=20
> > > The description content will be handled as a ReST file.
> > >=20
> > > I don't have any time right now to do this change and to handle the
> > > warnings that will start to popup.
> > >=20
> > > Btw, a single replace there is enough to show the amount of problems =
that
> > > it will rise, as it will basically break Sphinx build with:
> > >=20
> > > 	reading sources... [  1%] admin-guide/abi-testing
> > > 	reST markup error:
> > > 	get_abi.pl rest --dir $srctree/Documentation/ABI/testing:45261: (SEV=
ERE/4) Missing matching underline for section title overline.
> > > =09
> > > 	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > 	PCIe Device AER statistics
> > > 	These attributes show up under all the devices that are AER capable.=
 These =20
> >=20
> > To be clear here: the problem with the above is that ReST has zero
> > tolerance and actually behaves like a crash, if it receives something l=
ike:
> >=20
> >    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >    PCIe Device AER statistics
> >    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >=20
> > For it to work, it has to have zero spaces before =3D=3D=3D..=3D=3D=3D =
line, e. g.:
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > PCIe Device AER statistics
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >=20
> > Ok, maybe we could try to teach the parser a way to identify the initial
> > spacing of the first description line and remove that amount of=20
> > spaces/tabs for the following lines, but it may require some heuristics=
. =20
>=20
> Or we can clean this type of thing up by hand :)
>=20
> Let's see how bad this gets, the documentation in these files should not
> be very complex as they _should_ only be one-value-per-file, but as you
> have shown in this very example, that rule is violated :(

Hi Greg,

Doing a manual review - still incomplete (just stable/ dir) - and I didn't
try to run the script over ABI file yet - this is what I found so
far[1]: 17 files over 37 needed adjustments (45%).

That trick of detecting a complex file when it finds a ':' and parse the
hole description as a literal block solves most of them.

=46rom the changes below, this file:
	Documentation/ABI/stable/sysfs-driver-mlxreg-io

Found a "creative way" to place the "What:" field avoiding long lines...

At least this one should be fixed, as the parser won't handle its
content right (it won't complain, but the result output will be wrong).

[1] I also added a note at README that files should be ReST-compatible


diff --git a/Documentation/ABI/README b/Documentation/ABI/README
index 3121029dce21..8bac9cb09a6d 100644
--- a/Documentation/ABI/README
+++ b/Documentation/ABI/README
@@ -32,7 +32,7 @@ The different levels of stability are:
 	layout of the files below for details on how to do this.)
=20
   obsolete/
-  	This directory documents interfaces that are still remaining in
+	This directory documents interfaces that are still remaining in
 	the kernel, but are marked to be removed at some later point in
 	time.  The description of the interface will document the reason
 	why it is obsolete and when it can be expected to be removed.
@@ -58,6 +58,14 @@ Users:		All users of this interface who wish to be notif=
ied when
 		be changed further.
=20
=20
+Note:
+   The fields should be use a simple notation, compatible with ReST markup.
+   Also, the file **should not** have a top-level index, like::
+
+	=3D=3D=3D
+	foo
+	=3D=3D=3D
+
 How things move between levels:
=20
 Interfaces in stable may move to obsolete, as long as the proper
diff --git a/Documentation/ABI/stable/firewire-cdev b/Documentation/ABI/sta=
ble/firewire-cdev
index f72ed653878a..d8df3004c318 100644
--- a/Documentation/ABI/stable/firewire-cdev
+++ b/Documentation/ABI/stable/firewire-cdev
@@ -20,6 +20,7 @@ Description:
 			  - Query node ID
 			  - Query maximum speed of the path between this node
 			    and local node
+
 		  - The 1394 bus (i.e. "card") to which the node is attached to:
 			  - Isochronous stream transmission and reception
 			  - Asynchronous stream transmission and reception
@@ -31,6 +32,7 @@ Description:
 			    manager
 			  - Query cycle time
 			  - Bus reset initiation, bus reset event reception
+
 		  - All 1394 buses:
 			  - Allocation of IEEE 1212 address ranges on the local
 			    link layers, reception of inbound requests to such
diff --git a/Documentation/ABI/stable/sysfs-acpi-pmprofile b/Documentation/=
ABI/stable/sysfs-acpi-pmprofile
index 964c7a8afb26..3b0e34eef83c 100644
--- a/Documentation/ABI/stable/sysfs-acpi-pmprofile
+++ b/Documentation/ABI/stable/sysfs-acpi-pmprofile
@@ -11,12 +11,15 @@ Values:         For possible values see ACPI specificat=
ion:
 		Field: Preferred_PM_Profile
=20
 		Currently these values are defined by spec:
-		0 Unspecified
-		1 Desktop
-		2 Mobile
-		3 Workstation
-		4 Enterprise Server
-		5 SOHO Server
-		6 Appliance PC
-		7 Performance Server
+
+		=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+		0  Unspecified
+		1  Desktop
+		2  Mobile
+		3  Workstation
+		4  Enterprise Server
+		5  SOHO Server
+		6  Appliance PC
+		7  Performance Server
 		>7 Reserved
+		=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/ABI/stable/sysfs-bus-firewire b/Documentation/AB=
I/stable/sysfs-bus-firewire
index 41e5a0cd1e3e..0c8c023855b6 100644
--- a/Documentation/ABI/stable/sysfs-bus-firewire
+++ b/Documentation/ABI/stable/sysfs-bus-firewire
@@ -125,7 +125,9 @@ Description:
 		Read-only attribute, immutable during the target's lifetime.
 		Format, as exposed by firewire-sbp2 since 2.6.22, May 2007:
 		Colon-separated hexadecimal string representations of
+
 			u64 EUI-64 : u24 directory_ID : u16 LUN
+
 		without 0x prefixes, without whitespace.  The former sbp2 driver
 		(removed in 2.6.37 after being superseded by firewire-sbp2) used
 		a somewhat shorter format which was not as close to SAM.
diff --git a/Documentation/ABI/stable/sysfs-bus-nvmem b/Documentation/ABI/s=
table/sysfs-bus-nvmem
index 9ffba8576f7b..c399323f37de 100644
--- a/Documentation/ABI/stable/sysfs-bus-nvmem
+++ b/Documentation/ABI/stable/sysfs-bus-nvmem
@@ -9,13 +9,14 @@ Description:
 		Note: This file is only present if CONFIG_NVMEM_SYSFS
 		is enabled
=20
-		ex:
-		hexdump /sys/bus/nvmem/devices/qfprom0/nvmem
+		ex::
=20
-		0000000 0000 0000 0000 0000 0000 0000 0000 0000
-		*
-		00000a0 db10 2240 0000 e000 0c00 0c00 0000 0c00
-		0000000 0000 0000 0000 0000 0000 0000 0000 0000
-		...
-		*
-		0001000
+		  hexdump /sys/bus/nvmem/devices/qfprom0/nvmem
+
+		  0000000 0000 0000 0000 0000 0000 0000 0000 0000
+		  *
+		  00000a0 db10 2240 0000 e000 0c00 0c00 0000 0c00
+		  0000000 0000 0000 0000 0000 0000 0000 0000 0000
+		  ...
+		  *
+		  0001000
diff --git a/Documentation/ABI/stable/sysfs-bus-usb b/Documentation/ABI/sta=
ble/sysfs-bus-usb
index b832eeff9999..cad4bc232520 100644
--- a/Documentation/ABI/stable/sysfs-bus-usb
+++ b/Documentation/ABI/stable/sysfs-bus-usb
@@ -50,8 +50,10 @@ Description:
=20
 		Tools can use this file and the connected_duration file to
 		compute the percentage of time that a device has been active.
-		For example,
-		echo $((100 * `cat active_duration` / `cat connected_duration`))
+		For example::
+
+		  echo $((100 * `cat active_duration` / `cat connected_duration`))
+
 		will give an integer percentage.  Note that this does not
 		account for counter wrap.
 Users:
diff --git a/Documentation/ABI/stable/sysfs-class-backlight b/Documentation=
/ABI/stable/sysfs-class-backlight
index 70302f370e7e..023fb52645f8 100644
--- a/Documentation/ABI/stable/sysfs-class-backlight
+++ b/Documentation/ABI/stable/sysfs-class-backlight
@@ -4,6 +4,7 @@ KernelVersion:	2.6.12
 Contact:	Richard Purdie <rpurdie@rpsys.net>
 Description:
 		Control BACKLIGHT power, values are FB_BLANK_* from fb.h
+
 		 - FB_BLANK_UNBLANK (0)   : power on.
 		 - FB_BLANK_POWERDOWN (4) : power off
 Users:		HAL
diff --git a/Documentation/ABI/stable/sysfs-class-infiniband b/Documentatio=
n/ABI/stable/sysfs-class-infiniband
index 17211ceb9bf4..3f58952a8ccb 100644
--- a/Documentation/ABI/stable/sysfs-class-infiniband
+++ b/Documentation/ABI/stable/sysfs-class-infiniband
@@ -8,12 +8,14 @@ Date:		Apr, 2005
 KernelVersion:	v2.6.12
 Contact:	linux-rdma@vger.kernel.org
 Description:
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		node_type:	(RO) Node type (CA, RNIC, usNIC, usNIC UDP,
 				switch or router)
=20
 		node_guid:	(RO) Node GUID
=20
 		sys_image_guid:	(RO) System image GUID
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
 What:		/sys/class/infiniband/<device>/node_desc
@@ -47,6 +49,7 @@ KernelVersion:	v2.6.12
 Contact:	linux-rdma@vger.kernel.org
 Description:
=20
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		lid:		(RO) Port LID
=20
 		rate:		(RO) Port data rate (active width * active
@@ -66,8 +69,9 @@ Description:
=20
 		cap_mask:	(RO) Port capability mask. 2 bits here are
 				settable- IsCommunicationManagementSupported
-				(set when CM module is loaded) and IsSM (set via
-				open of issmN file).
+				(set when CM module is loaded) and IsSM (set
+				via open of issmN file).
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
 What:		/sys/class/infiniband/<device>/ports/<port-num>/link_layer
@@ -143,7 +147,7 @@ Description:
 		poor link signal integrity
=20
 		Data info:
-		---------
+		----------
=20
 		port_xmit_data: (RO) Total number of data octets, divided by 4
 		(lanes), transmitted on all VLs. This is 64 bit counter
@@ -177,7 +181,7 @@ Description:
 		packets with errors.
=20
 		Misc info:
-		---------
+		----------
=20
 		port_xmit_discards: (RO) Total number of outbound packets
 		discarded by the port because the port is down or congested.
@@ -244,9 +248,11 @@ Description:
 		two umad devices and two issm devices, while a switch will have
 		one device of each type (for switch port 0).
=20
+		=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		ibdev:	(RO) Show Infiniband (IB) device name
=20
 		port:	(RO) Display port number
+		=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
 What:		/sys/class/infiniband_mad/abi_version
@@ -281,10 +287,12 @@ Date:		Sept, 2005
 KernelVersion:	v2.6.14
 Contact:	linux-rdma@vger.kernel.org
 Description:
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		ibdev:		(RO) Display Infiniband (IB) device name
=20
 		abi_version:	(RO) Show ABI version of IB device specific
 				interfaces.
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
 What:		/sys/class/infiniband_verbs/abi_version
@@ -306,12 +314,14 @@ Date:		Apr, 2005
 KernelVersion:	v2.6.12
 Contact:	linux-rdma@vger.kernel.org
 Description:
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		hw_rev:		(RO) Hardware revision number
=20
 		hca_type:	(RO) Host Channel Adapter type: MT23108, MT25208
 				(MT23108 compat mode), MT25208 or MT25204
=20
 		board_id:	(RO) Manufacturing board ID
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
 sysfs interface for Chelsio T3 RDMA Driver (cxgb3)
@@ -324,6 +334,7 @@ Date:		Feb, 2007
 KernelVersion:	v2.6.21
 Contact:	linux-rdma@vger.kernel.org
 Description:
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		hw_rev:		(RO) Hardware revision number
=20
 		hca_type:	(RO) HCA type. Here it is a driver short name.
@@ -331,6 +342,7 @@ Description:
 				driver structure (e.g.  pci_driver::name).
=20
 		board_id:	(RO) Manufacturing board id
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
 sysfs interface for Mellanox ConnectX HCA IB driver (mlx4)
@@ -343,11 +355,13 @@ Date:		Sep, 2007
 KernelVersion:	v2.6.24
 Contact:	linux-rdma@vger.kernel.org
 Description:
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		hw_rev:		(RO) Hardware revision number
=20
 		hca_type:	(RO) Host channel adapter type
=20
 		board_id:	(RO) Manufacturing board ID
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
 What:		/sys/class/infiniband/mlx4_X/iov/ports/<port-num>/gids/<n>
@@ -373,6 +387,7 @@ Description:
 		example, ports/1/pkeys/10 contains the value at index 10 in port
 		1's P_Key table.
=20
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		gids/<n>:		(RO) The physical port gids n =3D 0..127
=20
 		admin_guids/<n>:	(RW) Allows examining or changing the
@@ -401,6 +416,7 @@ Description:
 					guest, whenever it uses its pkey index
 					1, will actually be using the real pkey
 					index 10.
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
 What:		/sys/class/infiniband/mlx4_X/iov/<pci-slot-num>/ports/<m>/smi_enabl=
ed
@@ -412,12 +428,14 @@ Description:
 		Enabling QP0 on VFs for selected VF/port. By default, no VFs are
 		enabled for QP0 operation.
=20
-		smi_enabled:	(RO) Indicates whether smi is currently enabled
-				for the indicated VF/port
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+		smi_enabled:	  (RO) Indicates whether smi is currently enabled
+				       for the indicated VF/port
=20
-		enable_smi_admin:(RW) Used by the admin to request that smi
-				capability be enabled or disabled for the
-				indicated VF/port. 0 =3D disable, 1 =3D enable.
+		enable_smi_admin: (RW) Used by the admin to request that smi
+				       capability be enabled or disabled for the
+				       indicated VF/port. 0 =3D disable, 1 =3D enable.
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 		The requested enablement will occur at the next reset of the VF
 		(e.g. driver restart on the VM which owns the VF).
@@ -433,11 +451,13 @@ Date:		Feb, 2008
 KernelVersion:	v2.6.25
 Contact:	linux-rdma@vger.kernel.org
 Description:
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
 		hw_rev:		(RO) Hardware revision number
=20
 		hca_type:	(RO) Host Channel Adapter type (NEX020)
=20
 		board_id:	(RO) Manufacturing board id
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
=20
=20
 sysfs interface for Chelsio T4/T5 RDMA driver (cxgb4)
@@ -451,6 +471,7 @@ KernelVersion:	v2.6.35
 Contact:	linux-rdma@vger.kernel.org
 Description:
=20
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		hw_rev:		(RO) Hardware revision number
=20
 		hca_type:	(RO) Driver short name. Should normally match
@@ -459,6 +480,7 @@ Description:
=20
 		board_id:	(RO) Manufacturing board id. (Vendor + device
 				information)
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
 sysfs interface for Intel IB driver qib
@@ -479,6 +501,7 @@ Date:		May, 2010
 KernelVersion:	v2.6.35
 Contact:	linux-rdma@vger.kernel.org
 Description:
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		version:	(RO) Display version information of installed software
 				and drivers.
=20
@@ -505,6 +528,7 @@ Description:
 		chip_reset:	(WO) Reset the chip if possible by writing
 				"reset" to this file. Only allowed if no user
 				contexts are open that use chip resources.
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
 What:		/sys/class/infiniband/qibX/ports/N/sl2vl/[0-15]
@@ -524,6 +548,7 @@ Contact:	linux-rdma@vger.kernel.org
 Description:
 		Per-port congestion control. Both are binary attributes.
=20
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		cc_table_bin:	(RO) Congestion control table size followed by
 				table entries.
=20
@@ -532,6 +557,7 @@ Description:
 				congestion entries - increase, timer, event log
 				trigger threshold and the minimum injection rate
 				delay.
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 What:		/sys/class/infiniband/qibX/ports/N/linkstate/loopback
 What:		/sys/class/infiniband/qibX/ports/N/linkstate/led_override
@@ -544,6 +570,7 @@ Contact:	linux-rdma@vger.kernel.org
 Description:
 		[to be documented]
=20
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		loopback:	(WO)
 		led_override:	(WO)
 		hrtbt_enable:	(RW)
@@ -554,6 +581,7 @@ Description:
 				errors. Possible states are- "Initted",
 				"Present", "IB_link_up", "IB_configured" or
 				"Fatal_Hardware_Error".
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 What:		/sys/class/infiniband/qibX/ports/N/diag_counters/rc_resends
 What:		/sys/class/infiniband/qibX/ports/N/diag_counters/seq_naks
@@ -602,6 +630,7 @@ Contact:	Christian Benvenuti <benve@cisco.com>,
 		linux-rdma@vger.kernel.org
 Description:
=20
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		board_id:	(RO) Manufacturing board id
=20
 		config:		(RO) Report the configuration for this PF
@@ -614,6 +643,7 @@ Description:
=20
 		iface:		(RO) Shows which network interface this usNIC
 				entry is associated to (visible with ifconfig).
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 What:		/sys/class/infiniband/usnic_X/qpn/summary
 What:		/sys/class/infiniband/usnic_X/qpn/context
@@ -658,6 +688,7 @@ Date:		May, 2016
 KernelVersion:	v4.6
 Contact:	linux-rdma@vger.kernel.org
 Description:
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		hw_rev:		(RO) Hardware revision number
=20
 		board_id:	(RO) Manufacturing board id
@@ -676,6 +707,7 @@ Description:
 				available.
=20
 		tempsense:	(RO) Thermal sense information
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
 What:		/sys/class/infiniband/hfi1_X/ports/N/CCMgtA/cc_settings_bin
@@ -687,19 +719,21 @@ Contact:	linux-rdma@vger.kernel.org
 Description:
 		Per-port congestion control.
=20
-		cc_table_bin:	(RO) CCA tables used by PSM2 Congestion control
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+		cc_table_bin	(RO) CCA tables used by PSM2 Congestion control
 				table size followed by table entries. Binary
 				attribute.
=20
-		cc_settings_bin:(RO) Congestion settings: port control, control
+		cc_settings_bin (RO) Congestion settings: port control, control
 				map and an array of 16 entries for the
 				congestion entries - increase, timer, event log
 				trigger threshold and the minimum injection rate
 				delay. Binary attribute.
=20
-		cc_prescan:	(RW) enable prescanning for faster BECN
+		cc_prescan	(RW) enable prescanning for faster BECN
 				response. Write "on" to enable and "off" to
 				disable.
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 What:		/sys/class/infiniband/hfi1_X/ports/N/sc2vl/[0-31]
 What:		/sys/class/infiniband/hfi1_X/ports/N/sl2sc/[0-31]
@@ -708,11 +742,13 @@ Date:		May, 2016
 KernelVersion:	v4.6
 Contact:	linux-rdma@vger.kernel.org
 Description:
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		sc2vl/:		(RO) 32 files (0 - 31) used to translate sl->vl
=20
 		sl2sc/:		(RO) 32 files (0 - 31) used to translate sl->sc
=20
 		vl2mtu/:	(RO) 16 files (0 - 15) used to determine MTU for vl
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
 What:		/sys/class/infiniband/hfi1_X/sdma_N/cpu_list
@@ -723,26 +759,28 @@ Contact:	linux-rdma@vger.kernel.org
 Description:
 		sdma<N>/ contains one directory per sdma engine (0 - 15)
=20
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		cpu_list:	(RW) List of cpus for user-process to sdma
 				engine assignment.
=20
 		vl:		(RO) Displays the virtual lane (vl) the sdma
 				engine maps to.
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 		This interface gives the user control on the affinity settings
 		for the device. As an example, to set an sdma engine irq
 		affinity and thread affinity of a user processes to use the
 		sdma engine, which is "near" in terms of NUMA configuration, or
-		physical cpu location, the user will do:
+		physical cpu location, the user will do::
=20
-		echo "3" > /proc/irq/<N>/smp_affinity_list
-		echo "4-7" > /sys/devices/.../sdma3/cpu_list
-		cat /sys/devices/.../sdma3/vl
-		0
-		echo "8" > /proc/irq/<M>/smp_affinity_list
-		echo "9-12" > /sys/devices/.../sdma4/cpu_list
-		cat /sys/devices/.../sdma4/vl
-		1
+		  echo "3" > /proc/irq/<N>/smp_affinity_list
+		  echo "4-7" > /sys/devices/.../sdma3/cpu_list
+		  cat /sys/devices/.../sdma3/vl
+		  0
+		  echo "8" > /proc/irq/<M>/smp_affinity_list
+		  echo "9-12" > /sys/devices/.../sdma4/cpu_list
+		  cat /sys/devices/.../sdma4/vl
+		  1
=20
 		to make sure that when a process runs on cpus 4,5,6, or 7, and
 		uses vl=3D0, then sdma engine 3 is selected by the driver, and
@@ -764,11 +802,13 @@ Date:		Jan, 2016
 KernelVersion:	v4.10
 Contact:	linux-rdma@vger.kernel.org
 Description:
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		hw_rev:		(RO) Hardware revision number
=20
 		hca_type:	(RO) Show HCA type (I40IW)
=20
 		board_id:	(RO) I40IW board ID
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
 sysfs interface for QLogic qedr NIC Driver
@@ -781,9 +821,11 @@ KernelVersion:	v4.10
 Contact:	linux-rdma@vger.kernel.org
 Description:
=20
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		hw_rev:		(RO) Hardware revision number
=20
 		hca_type:	(RO) Display HCA type
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
 sysfs interface for VMware Paravirtual RDMA driver
@@ -797,11 +839,13 @@ KernelVersion:	v4.10
 Contact:	linux-rdma@vger.kernel.org
 Description:
=20
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
 		hw_rev:		(RO) Hardware revision number
=20
 		hca_type:	(RO) Host channel adapter type
=20
 		board_id:	(RO) Display PVRDMA manufacturing board ID
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
 sysfs interface for Broadcom NetXtreme-E RoCE driver
@@ -813,6 +857,8 @@ Date:		Feb, 2017
 KernelVersion:	v4.11
 Contact:	linux-rdma@vger.kernel.org
 Description:
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		hw_rev:		(RO) Hardware revision number
=20
 		hca_type:	(RO) Host channel adapter type
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/ABI/stable/sysfs-class-rfkill b/Documentation/AB=
I/stable/sysfs-class-rfkill
index 80151a409d67..370254b6296a 100644
--- a/Documentation/ABI/stable/sysfs-class-rfkill
+++ b/Documentation/ABI/stable/sysfs-class-rfkill
@@ -54,6 +54,7 @@ Description: 	Current state of the transmitter.
 		through this interface. There will likely be another attempt to
 		remove it in the future.
 Values: 	A numeric value.
+
 		0: RFKILL_STATE_SOFT_BLOCKED
 			transmitter is turned off by software
 		1: RFKILL_STATE_UNBLOCKED
@@ -69,6 +70,7 @@ KernelVersion	v2.6.34
 Contact:	linux-wireless@vger.kernel.org
 Description: 	Current hardblock state. This file is read only.
 Values: 	A numeric value.
+
 		0: inactive
 			The transmitter is (potentially) active.
 		1: active
@@ -82,6 +84,7 @@ KernelVersion	v2.6.34
 Contact:	linux-wireless@vger.kernel.org
 Description:	Current softblock state. This file is read and write.
 Values: 	A numeric value.
+
 		0: inactive
 			The transmitter is (potentially) active.
 		1: active
diff --git a/Documentation/ABI/stable/sysfs-class-tpm b/Documentation/ABI/s=
table/sysfs-class-tpm
index c0e23830f56a..bbee8899a90e 100644
--- a/Documentation/ABI/stable/sysfs-class-tpm
+++ b/Documentation/ABI/stable/sysfs-class-tpm
@@ -32,11 +32,11 @@ KernelVersion:	2.6.12
 Contact:	tpmdd-devel@lists.sf.net
 Description:	The "caps" property contains TPM manufacturer and version inf=
o.
=20
-		Example output:
+		Example output::
=20
-		Manufacturer: 0x53544d20
-		TCG version: 1.2
-		Firmware version: 8.16
+		  Manufacturer: 0x53544d20
+		  TCG version: 1.2
+		  Firmware version: 8.16
=20
 		Manufacturer is a hex dump of the 4 byte manufacturer info
 		space in a TPM. TCG version shows the TCG TPM spec level that
@@ -54,9 +54,9 @@ Description:	The "durations" property shows the 3 vendor-=
specific values
 		any longer than necessary before starting to poll for a
 		result.
=20
-		Example output:
+		Example output::
=20
-		3015000 4508000 180995000 [original]
+		  3015000 4508000 180995000 [original]
=20
 		Here the short, medium and long durations are displayed in
 		usecs. "[original]" indicates that the values are displayed
@@ -92,14 +92,14 @@ Description:	The "pcrs" property will dump the current =
value of all Platform
 		values may be constantly changing, the output is only valid
 		for a snapshot in time.
=20
-		Example output:
+		Example output::
=20
-		PCR-00: 3A 3F 78 0F 11 A4 B4 99 69 FC AA 80 CD 6E 39 57 C3 3B 22 75
-		PCR-01: 3A 3F 78 0F 11 A4 B4 99 69 FC AA 80 CD 6E 39 57 C3 3B 22 75
-		PCR-02: 3A 3F 78 0F 11 A4 B4 99 69 FC AA 80 CD 6E 39 57 C3 3B 22 75
-		PCR-03: 3A 3F 78 0F 11 A4 B4 99 69 FC AA 80 CD 6E 39 57 C3 3B 22 75
-		PCR-04: 3A 3F 78 0F 11 A4 B4 99 69 FC AA 80 CD 6E 39 57 C3 3B 22 75
-		...
+		  PCR-00: 3A 3F 78 0F 11 A4 B4 99 69 FC AA 80 CD 6E 39 57 C3 3B 22 75
+		  PCR-01: 3A 3F 78 0F 11 A4 B4 99 69 FC AA 80 CD 6E 39 57 C3 3B 22 75
+		  PCR-02: 3A 3F 78 0F 11 A4 B4 99 69 FC AA 80 CD 6E 39 57 C3 3B 22 75
+		  PCR-03: 3A 3F 78 0F 11 A4 B4 99 69 FC AA 80 CD 6E 39 57 C3 3B 22 75
+		  PCR-04: 3A 3F 78 0F 11 A4 B4 99 69 FC AA 80 CD 6E 39 57 C3 3B 22 75
+		  ...
=20
 		The number of PCRs and hex bytes needed to represent a PCR
 		value will vary depending on TPM chip version. For TPM 1.1 and
@@ -119,44 +119,44 @@ Description:	The "pubek" property will return the TPM=
's public endorsement
 		ated at TPM manufacture time and exists for the life of the
 		chip.
=20
-		Example output:
-
-		Algorithm: 00 00 00 01
-		Encscheme: 00 03
-		Sigscheme: 00 01
-		Parameters: 00 00 08 00 00 00 00 02 00 00 00 00
-		Modulus length: 256
-		Modulus:
-		B4 76 41 82 C9 20 2C 10 18 40 BC 8B E5 44 4C 6C
-		3A B2 92 0C A4 9B 2A 83 EB 5C 12 85 04 48 A0 B6
-		1E E4 81 84 CE B2 F2 45 1C F0 85 99 61 02 4D EB
-		86 C4 F7 F3 29 60 52 93 6B B2 E5 AB 8B A9 09 E3
-		D7 0E 7D CA 41 BF 43 07 65 86 3C 8C 13 7A D0 8B
-		82 5E 96 0B F8 1F 5F 34 06 DA A2 52 C1 A9 D5 26
-		0F F4 04 4B D9 3F 2D F2 AC 2F 74 64 1F 8B CD 3E
-		1E 30 38 6C 70 63 69 AB E2 50 DF 49 05 2E E1 8D
-		6F 78 44 DA 57 43 69 EE 76 6C 38 8A E9 8E A3 F0
-		A7 1F 3C A8 D0 12 15 3E CA 0E BD FA 24 CD 33 C6
-		47 AE A4 18 83 8E 22 39 75 93 86 E6 FD 66 48 B6
-		10 AD 94 14 65 F9 6A 17 78 BD 16 53 84 30 BF 70
-		E0 DC 65 FD 3C C6 B0 1E BF B9 C1 B5 6C EF B1 3A
-		F8 28 05 83 62 26 11 DC B4 6B 5A 97 FF 32 26 B6
-		F7 02 71 CF 15 AE 16 DD D1 C1 8E A8 CF 9B 50 7B
-		C3 91 FF 44 1E CF 7C 39 FE 17 77 21 20 BD CE 9B
-
-		Possible values:
-
-		Algorithm:	TPM_ALG_RSA			(1)
-		Encscheme:	TPM_ES_RSAESPKCSv15		(2)
+		Example output::
+
+		  Algorithm: 00 00 00 01
+		  Encscheme: 00 03
+		  Sigscheme: 00 01
+		  Parameters: 00 00 08 00 00 00 00 02 00 00 00 00
+		  Modulus length: 256
+		  Modulus:
+		  B4 76 41 82 C9 20 2C 10 18 40 BC 8B E5 44 4C 6C
+		  3A B2 92 0C A4 9B 2A 83 EB 5C 12 85 04 48 A0 B6
+		  1E E4 81 84 CE B2 F2 45 1C F0 85 99 61 02 4D EB
+		  86 C4 F7 F3 29 60 52 93 6B B2 E5 AB 8B A9 09 E3
+		  D7 0E 7D CA 41 BF 43 07 65 86 3C 8C 13 7A D0 8B
+		  82 5E 96 0B F8 1F 5F 34 06 DA A2 52 C1 A9 D5 26
+		  0F F4 04 4B D9 3F 2D F2 AC 2F 74 64 1F 8B CD 3E
+		  1E 30 38 6C 70 63 69 AB E2 50 DF 49 05 2E E1 8D
+		  6F 78 44 DA 57 43 69 EE 76 6C 38 8A E9 8E A3 F0
+		  A7 1F 3C A8 D0 12 15 3E CA 0E BD FA 24 CD 33 C6
+		  47 AE A4 18 83 8E 22 39 75 93 86 E6 FD 66 48 B6
+		  10 AD 94 14 65 F9 6A 17 78 BD 16 53 84 30 BF 70
+		  E0 DC 65 FD 3C C6 B0 1E BF B9 C1 B5 6C EF B1 3A
+		  F8 28 05 83 62 26 11 DC B4 6B 5A 97 FF 32 26 B6
+		  F7 02 71 CF 15 AE 16 DD D1 C1 8E A8 CF 9B 50 7B
+		  C3 91 FF 44 1E CF 7C 39 FE 17 77 21 20 BD CE 9B
+
+		Possible values::
+
+		  Algorithm:	TPM_ALG_RSA			(1)
+		  Encscheme:	TPM_ES_RSAESPKCSv15		(2)
 				TPM_ES_RSAESOAEP_SHA1_MGF1	(3)
-		Sigscheme:	TPM_SS_NONE			(1)
-		Parameters, a byte string of 3 u32 values:
+		  Sigscheme:	TPM_SS_NONE			(1)
+		  Parameters, a byte string of 3 u32 values:
 			Key Length (bits):	00 00 08 00	(2048)
 			Num primes:		00 00 00 02	(2)
 			Exponent Size:		00 00 00 00	(0 means the
 								 default exp)
-		Modulus Length: 256 (bytes)
-		Modulus:	The 256 byte Endorsement Key modulus
+		  Modulus Length: 256 (bytes)
+		  Modulus:	The 256 byte Endorsement Key modulus
=20
 What:		/sys/class/tpm/tpmX/device/temp_deactivated
 Date:		April 2006
@@ -176,9 +176,9 @@ Description:	The "timeouts" property shows the 4 vendor=
-specific values
 		timeouts is defined by the TPM interface spec that the chip
 		conforms to.
=20
-		Example output:
+		Example output::
=20
-		750000 750000 750000 750000 [original]
+		  750000 750000 750000 750000 [original]
=20
 		The four timeout values are shown in usecs, with a trailing
 		"[original]" or "[adjusted]" depending on whether the values
diff --git a/Documentation/ABI/stable/sysfs-devices b/Documentation/ABI/sta=
ble/sysfs-devices
index 4404bd9b96c1..42bf1eab5677 100644
--- a/Documentation/ABI/stable/sysfs-devices
+++ b/Documentation/ABI/stable/sysfs-devices
@@ -1,5 +1,6 @@
-# Note: This documents additional properties of any device beyond what
-# is documented in Documentation/admin-guide/sysfs-rules.rst
+Note:
+  This documents additional properties of any device beyond what
+  is documented in Documentation/admin-guide/sysfs-rules.rst
=20
 What:		/sys/devices/*/of_node
 Date:		February 2015
diff --git a/Documentation/ABI/stable/sysfs-driver-ib_srp b/Documentation/A=
BI/stable/sysfs-driver-ib_srp
index 7049a2b50359..2d706b4900ce 100644
--- a/Documentation/ABI/stable/sysfs-driver-ib_srp
+++ b/Documentation/ABI/stable/sysfs-driver-ib_srp
@@ -6,6 +6,7 @@ Description:	Interface for making ib_srp connect to a new t=
arget.
 		One can request ib_srp to connect to a new target by writing
 		a comma-separated list of login parameters to this sysfs
 		attribute. The supported parameters are:
+
 		* id_ext, a 16-digit hexadecimal number specifying the eight
 		  byte identifier extension in the 16-byte SRP target port
 		  identifier. The target port identifier is sent by ib_srp
diff --git a/Documentation/ABI/stable/sysfs-driver-mlxreg-io b/Documentatio=
n/ABI/stable/sysfs-driver-mlxreg-io
index 156319fc5b80..3544968f43cc 100644
--- a/Documentation/ABI/stable/sysfs-driver-mlxreg-io
+++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
@@ -1,5 +1,4 @@
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
-							asic_health
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/asic_health
=20
 Date:		June 2018
 KernelVersion:	4.19
@@ -9,9 +8,8 @@ Description:	This file shows ASIC health status. The possib=
le values are:
=20
 		The files are read only.
=20
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
-							cpld1_version
-							cpld2_version
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld1_version
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld2_version
 Date:		June 2018
 KernelVersion:	4.19
 Contact:	Vadim Pasternak <vadimpmellanox.com>
@@ -20,8 +18,7 @@ Description:	These files show with which CPLD versions ha=
ve been burned
=20
 		The files are read only.
=20
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
-							fan_dir
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/fan_dir
=20
 Date:		December 2018
 KernelVersion:	5.0
@@ -32,8 +29,7 @@ Description:	This file shows the system fans direction:
=20
 		The files are read only.
=20
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
-							jtag_enable
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/jtag_enable
=20
 Date:		November 2018
 KernelVersion:	5.0
@@ -43,8 +39,7 @@ Description:	These files show with which CPLD versions ha=
ve been burned
=20
 		The files are read only.
=20
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
-							jtag_enable
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/jtag_enable
=20
 Date:		November 2018
 KernelVersion:	5.0
@@ -87,16 +82,15 @@ Description:	These files allow asserting system power c=
ycling, switching
=20
 		The files are write only.
=20
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
-							reset_aux_pwr_or_ref
-							reset_asic_thermal
-							reset_hotswap_or_halt
-							reset_hotswap_or_wd
-							reset_fw_reset
-							reset_long_pb
-							reset_main_pwr_fail
-							reset_short_pb
-							reset_sw_reset
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_aux_pwr_=
or_ref
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_asic_the=
rmal
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_hotswap_=
or_halt
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_hotswap_=
or_wd
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_fw_reset
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_long_pb
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_main_pwr=
_fail
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_short_pb
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_sw_reset
 Date:		June 2018
 KernelVersion:	4.19
 Contact:	Vadim Pasternak <vadimpmellanox.com>
@@ -110,11 +104,10 @@ Description:	These files show the system reset cause,=
 as following: power
=20
 		The files are read only.
=20
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
-						reset_comex_pwr_fail
-						reset_from_comex
-						reset_system
-						reset_voltmon_upgrade_fail
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_comex_pw=
r_fail
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_from_com=
ex
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_system
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_voltmon_=
upgrade_fail
=20
 Date:		November 2018
 KernelVersion:	5.0
diff --git a/Documentation/ABI/stable/sysfs-firmware-efi-vars b/Documentati=
on/ABI/stable/sysfs-firmware-efi-vars
index 5def20b9019e..46ccd233e359 100644
--- a/Documentation/ABI/stable/sysfs-firmware-efi-vars
+++ b/Documentation/ABI/stable/sysfs-firmware-efi-vars
@@ -17,6 +17,7 @@ Description:
 		directory has a name of the form "<key>-<vendor guid>"
 		and contains the following files:
=20
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
 		attributes:	A read-only text file enumerating the
 				EFI variable flags.  Potential values
 				include:
@@ -59,12 +60,14 @@ Description:
=20
 		size:		As ASCII representation of the size of
 				the variable's value.
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
=20
=20
 		In addition, two other magic binary files are provided
 		in the top-level directory and are used for adding and
 		removing variables:
=20
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
 		new_var:	Takes a "struct efi_variable" and
 				instructs the EFI firmware to create a
 				new variable.
@@ -73,3 +76,4 @@ Description:
 				instructs the EFI firmware to remove any
 				variable that has a matching vendor GUID
 				and variable key name.
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/ABI/stable/sysfs-firmware-opal-dump b/Documentat=
ion/ABI/stable/sysfs-firmware-opal-dump
index 32fe7f5c4880..1f74f45327ba 100644
--- a/Documentation/ABI/stable/sysfs-firmware-opal-dump
+++ b/Documentation/ABI/stable/sysfs-firmware-opal-dump
@@ -7,6 +7,7 @@ Description:
=20
 		This is only for the powerpc/powernv platform.
=20
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		initiate_dump:	When '1' is written to it,
 				we will initiate a dump.
 				Read this file for supported commands.
@@ -19,8 +20,11 @@ Description:
 				and ID of the dump, use the id and type files.
 				Do not rely on any particular size of dump
 				type or dump id.
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 		Each dump has the following files:
+
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		id:		An ASCII representation of the dump ID
 				in hex (e.g. '0x01')
 		type:		An ASCII representation of the type of
@@ -39,3 +43,4 @@ Description:
 				inaccessible.
 				Reading this file will get a list of
 				supported actions.
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/ABI/stable/sysfs-firmware-opal-elog b/Documentat=
ion/ABI/stable/sysfs-firmware-opal-elog
index 2536434d49d0..7c8a61a2d005 100644
--- a/Documentation/ABI/stable/sysfs-firmware-opal-elog
+++ b/Documentation/ABI/stable/sysfs-firmware-opal-elog
@@ -38,6 +38,7 @@ Description:
 		For each log entry (directory), there are the following
 		files:
=20
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		id:		An ASCII representation of the ID of the
 				error log, in hex - e.g. "0x01".
=20
@@ -58,3 +59,4 @@ Description:
 				entry will be removed from sysfs.
 				Reading this file will list the supported
 				operations (currently just acknowledge).
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/ABI/stable/sysfs-hypervisor-xen b/Documentation/=
ABI/stable/sysfs-hypervisor-xen
index 3cf5cdfcd9a8..01bd46be261e 100644
--- a/Documentation/ABI/stable/sysfs-hypervisor-xen
+++ b/Documentation/ABI/stable/sysfs-hypervisor-xen
@@ -33,6 +33,7 @@ Description:	If running under Xen:
 		Space separated list of supported guest system types. Each type
 		is in the format: <class>-<major>.<minor>-<arch>
 		With:
+			=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
 			<class>: "xen" -- x86: paravirtualized, arm: standard
 				 "hvm" -- x86 only: fully virtualized
 			<major>: major guest interface version
@@ -43,6 +44,7 @@ Description:	If running under Xen:
 				 "x86_64": 64 bit x86 guest
 				 "armv7l": 32 bit arm guest
 				 "aarch64": 64 bit arm guest
+			=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
=20
 What:		/sys/hypervisor/properties/changeset
 Date:		March 2009
diff --git a/Documentation/ABI/stable/vdso b/Documentation/ABI/stable/vdso
index 55406ec8a35a..73ed1240a5c0 100644
--- a/Documentation/ABI/stable/vdso
+++ b/Documentation/ABI/stable/vdso
@@ -23,6 +23,7 @@ Unless otherwise noted, the set of symbols with any given=
 version and the
 ABI of those symbols is considered stable.  It may vary across architectur=
es,
 though.
=20
-(As of this writing, this ABI documentation as been confirmed for x86_64.
+Note:
+ As of this writing, this ABI documentation as been confirmed for x86_64.
  The maintainers of the other vDSO-using architectures should confirm
- that it is correct for their architecture.)
+ that it is correct for their architecture.





Thanks,
Mauro
