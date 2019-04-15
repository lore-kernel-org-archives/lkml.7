Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E04C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1E420825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IF1vsBRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfDOGID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:08:03 -0400
Received: from ozlabs.org ([203.11.71.1]:52935 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfDOGID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 02:08:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44jJ2S365Kz9s55;
        Mon, 15 Apr 2019 16:08:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555308480;
        bh=LiUZAUkPESmSjJVIxSHZ/INj5aD7owdjdmwFg9A6+ho=;
        h=Date:From:To:Cc:Subject:From;
        b=IF1vsBRxknpuJaPpa90xDIPw4F6el70EhRNGnFN3wLWj9ZoHLj23YYd9Qb4evHvAA
         p73jrB62r5s5Hyyoqn37Q0/bj83+Q/2biKRvXBPxNbY9y3zLJi4T1XGAvQxXF0CzN/
         DMiBb7XUVnoDDdmqSXzR/gTe/hLPg/NRI796oTtTFJQJt4Nm/9uIyrMxeTzrr0mI3I
         hV2jNKB7nQz12eZsOx452H0lSwCOt7VXNNLUe+sIjh2jC4sWqWj3ckzZ4gjR/NqKTs
         PB7jytiOY2kTCpJuvUK49xVje457rbpRh4Ms3p4znbNvYnwi2to6aqsDGVhGjSjdZK
         G6Hq91NEdpVew==
Date:   Mon, 15 Apr 2019 16:07:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: linux-next: manual merge of the vhost tree with the pci tree
Message-ID: <20190415160758.390eaf8d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/V7udtFxG3FbkzLoVt4SOoB/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/V7udtFxG3FbkzLoVt4SOoB/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vhost tree got a conflict in:

  drivers/pci/of.c

between commit:

  9cb30a71acd4 ("PCI: OF: Support "external-facing" property")

from the pci tree and commit:

  e1c326663501 ("PCI: OF: Initialize dev->fwnode appropriately")

from the vhost tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/pci/of.c
index 73d5adec0a28,9454c90980c9..000000000000
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@@ -32,16 -34,13 +35,18 @@@ void pci_release_of_node(struct pci_de
 =20
  void pci_set_bus_of_node(struct pci_bus *bus)
  {
 -	if (bus->self =3D=3D NULL)
 -		bus->dev.of_node =3D pcibios_get_phb_of_node(bus);
 -	else
 -		bus->dev.of_node =3D of_node_get(bus->self->dev.of_node);
 +	struct device_node *node;
 =20
 -	if (bus->dev.of_node)
 -		bus->dev.fwnode =3D &bus->dev.of_node->fwnode;
 +	if (bus->self =3D=3D NULL) {
 +		node =3D pcibios_get_phb_of_node(bus);
 +	} else {
 +		node =3D of_node_get(bus->self->dev.of_node);
 +		if (node && of_property_read_bool(node, "external-facing"))
 +			bus->self->untrusted =3D true;
 +	}
 +	bus->dev.of_node =3D node;
++	if (node)
++		bus->dev.fwnode =3D &node->fwnode;
  }
 =20
  void pci_release_bus_of_node(struct pci_bus *bus)

--Sig_/V7udtFxG3FbkzLoVt4SOoB/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly0H74ACgkQAVBC80lX
0Gz3Swf3aCDVFBy1S3tddu+clorIixKLKHuMwQ/83DcW2kRgNpedCnjZKiNIkIpL
lswSefPpg3+t28ExpMQ3vGU8F9yL7lZ+gp81aCcpPPMdlJqKxxCxYXoeEG/CQgIw
t13K4HEHAB6CS1V3KCAqnzYMcpBXQVfA4ZuxCFS9T1R6iZA+kYN+5LaHRDrQos2n
OHzE1fn2Cs+fTNAsH+5Lh6ari4ri+C6jVDuOnyjOhHVAKQs9CRwJOYshUBQMzbgc
eQGOz412cXj9vGsk2R2LX3MbIH8/NxTL6TJJ5KbXARmmi0OacmKdJAYSeprJCLQA
n2GzXrn6C+KkeRT8e8A+O4MtKY2j
=Kfar
-----END PGP SIGNATURE-----

--Sig_/V7udtFxG3FbkzLoVt4SOoB/--
